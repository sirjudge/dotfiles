pragma ComponentBehavior: Bound
import Quickshell.Io
import QtQuick
import "../../components"
import "../../ConfigurationOptions"
import "../../services"

AnchoredDialog {
    id: popupRoot

    property bool isConnected: false
    property bool isWifi: false
    property bool isEthernet: false
    property string ssid: ""
    property string ip: ""
    property string gateway: ""
    property string linkRate: ""
    property int signal: 0

    property string dns: ""
    property string currentFreq: ""
    property bool wifiEnabled: false
    property var networks: []
    property bool scanning: false
    property var knownNetworks: []

    wantsFocus: true
    contentWidth: 320

    // Pinned body height so async updates never resize the window (which would
    // otherwise flash the popup): Wi-Fi gets a fixed height with the network list
    // filling whatever space is left below the details; Ethernet has no list, so
    // its height follows the (now constant) top section.
    readonly property int wifiContentHeight: 440
    contentHeight: popupRoot.isEthernet ? topSection.implicitHeight + Theme.popupPadding * 2 : wifiContentHeight

    // Side-effects on open/close, kept separate from AnchoredPopup's own
    // isOpen handler (which drives the show/hide animation).
    Connections {
        target: popupRoot
        function onIsOpenChanged() {
            if (popupRoot.isOpen) {
                extInfoProc.running = true;
                knownNetworksProc.running = true;
                if (popupRoot.isWifi && !popupRoot.isEthernet)
                    scanProc.running = true;
            }
        }
    }

    // Refresh details and rescan after a successful (dis)connection driven by
    // the shared NetworkService (e.g. via the password dialog).
    Connections {
        target: NetworkService
        function onConnectionChanged() {
            extInfoProc.running = true;
            knownNetworksProc.running = true;
            if (popupRoot.isWifi && !popupRoot.isEthernet)
                scanProc.running = true;
        }
        // Get out of the way once an attempt starts: progress is reported via a
        // notification, not in the popup.
        function onAttemptStarted() {
            popupRoot.requestClose();
        }
    }

    Item {
        anchors.fill: parent
        focus: true

        Keys.onEscapePressed: popupRoot.requestClose()

        // Header + connection details, anchored to the top with a constant
        // height per connection type. The Wi-Fi network list (below) fills the
        // remaining space down to the popup bottom.
        Column {
            id: topSection
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: Theme.popupPadding
            }
            spacing: Theme.spacingLarge

            NetworkConnectionHeader {
                width: parent.width
                isConnected: popupRoot.isConnected
                isWifi: popupRoot.isWifi
                isEthernet: popupRoot.isEthernet
                ssid: popupRoot.ssid
                signal: popupRoot.signal
                wifiEnabled: popupRoot.wifiEnabled
                onToggleWifiRequested: {
                    wifiToggleProc.targetState = !popupRoot.wifiEnabled;
                    popupRoot.wifiEnabled = wifiToggleProc.targetState;
                    wifiToggleProc.running = true;
                }
                onDisconnectRequested: disconnectProc.running = true
            }

            NetworkConnectionDetails {
                visible: popupRoot.isConnected
                height: visible ? implicitHeight : 0
                width: parent.width
                isWifi: popupRoot.isWifi
                ip: popupRoot.ip
                gateway: popupRoot.gateway
                dns: popupRoot.dns
                linkRate: popupRoot.linkRate
                signal: popupRoot.signal
                currentFreq: popupRoot.currentFreq
            }

            Divider {
                visible: popupRoot.wifiEnabled && !popupRoot.isEthernet
                height: visible ? 1 : 0
                width: parent.width
            }
        }

        NetworkAvailableNetworks {
            visible: popupRoot.wifiEnabled && !popupRoot.isEthernet
            anchors {
                top: topSection.bottom
                topMargin: Theme.spacingLarge
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                leftMargin: Theme.popupPadding
                rightMargin: Theme.popupPadding
                bottomMargin: Theme.popupPadding
            }
            networks: popupRoot.networks
            scanning: popupRoot.scanning
            currentSsid: popupRoot.ssid
            knownNetworks: popupRoot.knownNetworks
            onForgetNetwork: ssid => NetworkService.forgetNetwork(ssid)
            onRefreshRequested: {
                popupRoot.scanning = true;
                scanProc.running = true;
                // Re-query saved profiles too, so the "known" highlighting and
                // Forget buttons reflect any changes (e.g. a just-forgotten net).
                knownNetworksProc.running = true;
                extInfoProc.running = true;
            }
            onConnectToNetwork: (ssid, isSecured, security) => {
                // Open / already-known networks connect immediately; an
                // unknown secured network needs a password via the dialog.
                var isKnown = popupRoot.knownNetworks.indexOf(ssid) >= 0;
                if (!isSecured || isKnown)
                    NetworkService.connectKnown(ssid);
                else
                    NetworkService.openPasswordDialog(ssid, security);
            }
        }
    }

    Process {
        id: extInfoProc
        command: ["sh", "-c",
            // Extract the active network interface name from the default route
            "iface=$(ip -4 route show default | awk 'NR==1{for(i=1;i<=NF;i++){if($i==\"dev\"){print $(i+1);exit}}}'); " +
            // Try NetworkManager directly for DNS servers (space-separated)
            "dns=$(nmcli -g IP4.DNS dev show \"$iface\" 2>/dev/null | tr '\n' ' ' | sed 's/[[:space:]]*$//'); " +
            // Fall back to systemd-resolved per-link DNS if NM returned nothing
            "[ -z \"$dns\" ] && dns=$(resolvectl dns \"$iface\" 2>/dev/null | awk '{for(i=3;i<=NF;i++)printf \"%s \",$i}' | sed 's/[[:space:]]*$//'); " +
            // Last resort: parse /etc/resolv.conf, skipping 127.x stub resolver entries
            "[ -z \"$dns\" ] && dns=$(grep \"^nameserver\" /etc/resolv.conf 2>/dev/null | grep -v \"127.0.0\" | awk '{printf \"%s \",$2}' | sed 's/[[:space:]]*$//'); " +
            // Get the active WiFi connection frequency in MHz
            "freq=$(nmcli -t -f ACTIVE,SSID,FREQ dev wifi 2>/dev/null | awk -F: '/^yes:/{print $NF;exit}' | awk '{print $1}'); " +
            // Check whether the WiFi radio is enabled or disabled
            "wifiEnabled=$(nmcli radio wifi 2>/dev/null | tr -d ' \n'); " +
            // Output all three values pipe-separated for the QML parser
            "printf \"%s|%s|%s\" \"$dns\" \"$freq\" \"$wifiEnabled\""]
        stdout: SplitParser {
            onRead: data => {
                if (!data.trim())
                    return;
                var parts = data.trim().split("|");
                popupRoot.dns = parts[0] ?? "";
                popupRoot.currentFreq = parts[1] ?? "";
                popupRoot.wifiEnabled = (parts[2] ?? "") === "enabled";
                if (popupRoot.wifiEnabled && popupRoot.isWifi && !popupRoot.isEthernet && popupRoot.networks.length === 0)
                    scanProc.running = true;
            }
        }
    }

    Process {
        id: scanProc
        property var networksBuf: []
        command: ["sh", "-c",
            // List all visible networks in terse format; parse SSID left-to-right and
            // FREQ/SECURITY/SIGNAL from the right to handle SSIDs that contain colons;
            // fields are delimited by \x01 to avoid conflicts with SSID characters
            "nmcli --terse -f SSID,SIGNAL,SECURITY,FREQ dev wifi list 2>/dev/null | " + "awk -F: 'NF>=4{freq=$NF;sec=$(NF-1);sig=$(NF-2);ssid=\"\";for(i=1;i<=NF-3;i++){if(i>1)ssid=ssid\":\";ssid=ssid$i};if(ssid!=\"\")printf \"%s\\x01%s\\x01%s\\x01%s\\n\",ssid,sig,sec,freq}'"]
        onRunningChanged: {
            if (running) {
                networksBuf = [];
                popupRoot.networks = [];
                popupRoot.scanning = true;
            } else {
                var seen = {};
                for (var i = 0; i < networksBuf.length; i++) {
                    var net = networksBuf[i];
                    var freq = parseInt(net.freq) || 0;
                    if (!(net.ssid in seen) || freq > (parseInt(seen[net.ssid].freq) || 0))
                        seen[net.ssid] = net;
                }
                popupRoot.networks = Object.values(seen).sort((a, b) => b.signal - a.signal);
                popupRoot.scanning = false;
            }
        }
        stdout: SplitParser {
            onRead: data => {
                if (!data.trim())
                    return;
                var parts = data.trim().split("\x01");
                if (parts.length < 4)
                    return;
                scanProc.networksBuf = scanProc.networksBuf.concat([
                    {
                        ssid: parts[0],
                        signal: parseInt(parts[1]) || 0,
                        security: parts[2].trim(),
                        freq: parts[3].trim()
                    }
                ]);
            }
        }
    }

    Process {
        id: wifiToggleProc
        property bool targetState: false
        command: ["sh", "-c",
            // Apply the requested radio state
            "nmcli radio wifi " + (wifiToggleProc.targetState ? "on" : "off") + " 2>/dev/null; " +
            // Read back the actual state so the UI reflects what NM committed
            "nmcli radio wifi 2>/dev/null | tr -d ' \n'"]
        stdout: SplitParser {
            onRead: data => {
                popupRoot.wifiEnabled = data.trim() === "enabled";
                if (!popupRoot.wifiEnabled)
                    popupRoot.networks = [];
                else
                    scanProc.running = true;
            }
        }
    }

    Process {
        id: knownNetworksProc
        command: ["sh", "-c",
            // List saved connections as TYPE:FILENAME:NAME (NAME last, since it can
            // contain colons; FILENAME is a path, so it cannot). Keep only WiFi
            // profiles backed by an on-disk file under /etc — i.e. persistent ones.
            // Runtime/in-memory connections (e.g. a "just this once" connect, whose
            // file lives under /run) are deliberately excluded so they don't show as
            // "known". The connection NAME equals the SSID for our WiFi profiles.
            "nmcli -t -f TYPE,FILENAME,NAME connection show 2>/dev/null | " + "awk -F: '$1==\"802-11-wireless\" && $2 ~ \"^/etc/\"{name=$3; for(i=4;i<=NF;i++)name=name\":\"$i; print name}'"]
        onRunningChanged: if (running)
            popupRoot.knownNetworks = []
        stdout: SplitParser {
            onRead: data => {
                var ssid = data.trim();
                if (ssid)
                    popupRoot.knownNetworks = popupRoot.knownNetworks.concat([ssid]);
            }
        }
    }

    Process {
        id: disconnectProc
        command: ["sh", "-c",
            // Resolve the active interface name from the default route, then disconnect it
            "nmcli dev disconnect $(ip -4 route show default | awk 'NR==1{for(i=1;i<=NF;i++){if($i==\"dev\"){print $(i+1);exit}}}') 2>/dev/null"]
        onRunningChanged: if (!running)
            extInfoProc.running = true
    }
}

