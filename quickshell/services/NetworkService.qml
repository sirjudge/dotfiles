pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick
import "../services"

// Centralized WiFi connection actions and the state behind the modal password
// dialog. The bar (and its NetworkPopup) is replicated per-monitor via Variants,
// but a connection attempt and its password dialog are global, single-shot
// affairs — so the logic lives here in a singleton and the popup/dialog become
// thin views over this state (mirroring the OSD singletons).
//
// In-flight progress, success and failure are reported entirely through
// notifications (see NotificationService): a resident "Connecting…" notification
// is shown while the attempt runs and replaced by a success/error notification
// once it settles. The dialog/popup are dismissed the moment an attempt begins.
QtObject {
    id: svc

    // ---- Modal dialog state -------------------------------------------------
    // Whether the modal password dialog should be shown.
    property bool dialogVisible: false
    // SSID the dialog is collecting a password for.
    property string dialogSsid: ""
    // Security string for that SSID (from the scan), used to pick key-mgmt.
    property string dialogSecurity: ""

    // ---- Shared attempt state -----------------------------------------------
    // True while a connect attempt is in flight. Drives the bar's connecting
    // icon and guards against overlapping attempts.
    property bool connecting: false
    // SSID of the in-flight attempt, shown in the bar tooltip while connecting.
    property string connectingSsid: ""

    // Emitted after a successful (dis)connection so views can refresh their
    // details and rescan.
    signal connectionChanged
    // Emitted the moment an attempt begins, so any open popup can dismiss itself
    // (the password dialog hides via dialogVisible; the per-monitor popup can't
    // be reached directly from here, so it listens for this instead).
    signal attemptStarted

    // Context of the in-flight attempt, read back in onExited.
    property string _attemptSsid: ""
    property bool _viaDialog: false
    // Set when the watchdog aborts an attempt, so onExited skips its own error
    // handling (the timeout already reported the failure).
    property bool _timedOut: false
    // Handle to the resident "Connecting…" notification for the current attempt.
    property var _connectNotif: null

    // ---- Public actions -----------------------------------------------------

    // Connect to an open network or one NetworkManager already has a profile
    // for. NM transparently tears down the current association first.
    function connectKnown(ssid) {
        // Guard: ignore new attempts while one is already running.
        if (svc.connecting)
            return;
        svc._beginAttempt(ssid, false);
        connectProc.command = ["sh", "-c", "SSID=\"$1\"; " +
            // When a saved profile already exists, activate it directly with
            // "connection up". This hands NM a single explicit target so it
            // switches APs without leaving the device disassociated — the gap that
            // "dev wifi connect" can open, during which NM's autoconnect may latch
            // onto a *different* known network instead of the one we asked for.
            // Match on the exact connection NAME (== SSID for our WiFi profiles).
            "if nmcli -g NAME connection show 2>/dev/null | grep -Fxq -- \"$SSID\"; then " + "nmcli connection up \"$SSID\" 2>&1; " +
            // No profile yet (e.g. a never-before-seen open network): create one by
            // associating, letting NM handle open auth.
            "else " + "nmcli dev wifi connect \"$SSID\" 2>&1; " + "fi", "--", ssid];
        connectProc.running = true;
    }

    // Reveal the modal password dialog for an unknown secured network.
    function openPasswordDialog(ssid, security) {
        // Guard: don't collect a new password mid-attempt.
        if (svc.connecting)
            return;
        svc.dialogSsid = ssid;
        svc.dialogSecurity = security;
        svc.dialogVisible = true;
    }

    // Attempt a secured connection with the given password. Beginning the attempt
    // dismisses the dialog; progress and outcome are reported via notifications.
    function connectWithPassword(ssid, password, remember, security) {
        // Guard: ignore new attempts while one is already running.
        if (svc.connecting)
            return;
        svc._beginAttempt(ssid, true);

        // WPA3 networks negotiate SAE; everything else uses the WPA/WPA2 PSK.
        var keyMgmt = (security && security.toUpperCase().includes("WPA3")) ? "sae" : "wpa-psk";
        // "yes" persists the profile to disk; "no" keeps it in memory only so it
        // vanishes on reboot / NM restart (the "just this once" case).
        var save = remember ? "yes" : "no";

        connectProc.command = ["sh", "-c",
            // Positional args ($1..$4) keep the password out of the shell text,
            // so there is no injection surface.
            "SSID=\"$1\"; PW=\"$2\"; KM=\"$3\"; SAVE=\"$4\"; " +
            // Drop any stale same-name profile (e.g. a previous wrong-password try)
            "nmcli connection delete \"$SSID\" >/dev/null 2>&1; " +
            // Create the profile (in-memory when SAVE=no) with the supplied secret
            "nmcli connection add type wifi con-name \"$SSID\" ssid \"$SSID\" " + "wifi-sec.key-mgmt \"$KM\" wifi-sec.psk \"$PW\" save \"$SAVE\" 2>&1; " +
            // Bring it up; capture combined output and the activation exit code
            "nmcli connection up \"$SSID\" 2>&1; rc=$?; " +
            // On failure, remove the profile so a bad password never lingers as a
            // "known" network on subsequent scans
            "[ $rc -ne 0 ] && nmcli connection delete \"$SSID\" >/dev/null 2>&1; " + "exit $rc", "--", ssid, password, keyMgmt, save];
        connectProc.running = true;
    }

    // Dismiss the dialog without connecting.
    function cancelDialog() {
        svc.dialogVisible = false;
    }

    // Permanently remove a saved network from NetworkManager's store. The network
    // reverts to "unknown" afterwards (a fresh password prompt on next connect).
    // connectionChanged is emitted so open views refresh their known-network list.
    function forgetNetwork(ssid) {
        forgetProc.command = ["sh", "-c", "SSID=\"$1\"; " +
            // Repeated connect attempts (and NM's own bookkeeping) can leave more
            // than one saved profile sharing an SSID; a plain delete-by-name leaves
            // the duplicates behind, so the network keeps showing as "known".
            // List every WiFi profile whose NAME equals the SSID and delete each by
            // its UUID (which never contains colons, so terse parsing is safe).
            "nmcli -t -f TYPE,UUID,NAME connection show 2>/dev/null | " + "awk -F: -v s=\"$SSID\" '$1==\"802-11-wireless\" && $3==s {print $2}' | " + "while read uuid; do nmcli connection delete uuid \"$uuid\" >/dev/null 2>&1; done", "--", ssid];
        forgetProc.running = true;
    }

    // ---- Internals ----------------------------------------------------------

    // Shared setup for both connect paths: flag the attempt context, dismiss the
    // dialog/popup, raise the resident notification and arm the watchdog.
    function _beginAttempt(ssid, viaDialog) {
        svc._attemptSsid = ssid;
        svc.connectingSsid = ssid;
        svc._viaDialog = viaDialog;
        svc._timedOut = false;
        svc.connecting = true;
        // The in-flight state now lives in a notification, so get the UI out of
        // the way: hide the password dialog and let the popup close itself.
        svc.dialogVisible = false;
        svc.attemptStarted();
        // Resident notification that persists for the duration of the attempt.
        svc._connectNotif = NotificationService.notifyPersistent("Connecting…", "Connecting to " + ssid + "…", "network-wireless");
        _timeoutTimer.restart();
    }

    // Dismiss the resident "Connecting…" notification, if any.
    function _clearConnectNotif() {
        if (svc._connectNotif) {
            svc._connectNotif.dismiss();
            svc._connectNotif = null;
        }
    }

    // Watchdog: abort an attempt that never settles. The shell that owns nmcli is
    // killed, any in-progress profile is torn down, and a timeout error surfaces.
    function _onTimeout() {
        if (!svc.connecting)
            return;
        svc._timedOut = true;
        svc.connecting = false;
        svc.connectingSsid = "";
        // Terminate the stuck nmcli pipeline.
        connectProc.running = false;
        // Cancel the pending activation; for a dialog-created profile, also remove
        // it from the registry (a known network's saved profile is left intact).
        // Deleting the profile via forgetNetwork tears down its activation too, so
        // the dialog case needs no separate "connection down".
        if (svc._viaDialog)
            svc.forgetNetwork(svc._attemptSsid);
        else
            Quickshell.execDetached(["sh", "-c", "nmcli connection down \"$1\" >/dev/null 2>&1", "--", svc._attemptSsid]);
        svc._clearConnectNotif();
        svc._notify("critical", "network-error", "Connection failed", svc._attemptSsid + ": connection timed out");
    }

    // Fire a desktop notification (routed to the shell's own daemon).
    function _notify(urgency, icon, summary, body) {
        Quickshell.execDetached(["notify-send", "-a", "Network", "-u", urgency, "-i", icon, summary, body]);
    }

    // Tears down a saved profile for forgetNetwork(); refreshes views on exit.
    property var forgetProc: Process {
        onExited: svc.connectionChanged()
    }

    property var _timeoutTimer: Timer {
        // time in s * 1000 to get ms
        interval: 30 * 1000
        repeat: false
        onTriggered: svc._onTimeout()
    }

    property var connectProc: Process {
        property string _output: ""

        onRunningChanged: if (running)
            _output = ""
        stdout: SplitParser {
            onRead: data => svc.connectProc._output += (svc.connectProc._output ? "\n" : "") + data.trim()
        }
        onExited: exitCode => {
            svc._timeoutTimer.stop();
            // The watchdog already reported and cleaned up this attempt.
            if (svc._timedOut) {
                svc._timedOut = false;
                return;
            }
            svc.connecting = false;
            var ssid = svc._attemptSsid;
            svc.connectingSsid = "";
            // Replace the resident "Connecting…" notification with the outcome.
            svc._clearConnectNotif();
            if (exitCode === 0) {
                NotificationService.notifySuccess("Connected", "Connected to " + ssid, "network-wireless");
                svc.connectionChanged();
            } else {
                // Surface the last meaningful line of nmcli's output as the detail.
                var lines = svc.connectProc._output.split("\n").filter(l => l.trim() !== "");
                var detail = lines.length > 0 ? lines[lines.length - 1].trim() : "Unknown error";
                svc._notify("critical", "network-error", "Connection failed", ssid + ": " + detail);
            }
        }
    }
}

