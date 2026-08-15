pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell.Services.Notifications
import QtQuick

// Shell-wide notification daemon. The bar is replicated per-monitor via
// Variants, but the org.freedesktop.Notifications D-Bus daemon must exist
// exactly once, so the NotificationServer lives here in a singleton (mirroring
// the IdleInhibitorState pattern). The popup window reads server.trackedNotifications.
QtObject {
    id: svc

    // The single notification server / daemon for the whole shell. Created on
    // startup unless running in dev mode (Config.devMode), where claiming the
    // org.freedesktop.Notifications D-Bus name would steal it from the real
    // shell instance — so a test bar leaves the running daemon untouched.
    property NotificationServer server: null

    property Component _serverComponent: Component {
        NotificationServer {
            // Don't persist across Quickshell reloads — popups are transient.
            keepOnReload: false
            persistenceSupported: false
            // Advertise only the capabilities the cards actually render.
            bodySupported: true
            bodyMarkupSupported: true
            imageSupported: true
            actionsSupported: true

            // Quickshell discards an incoming notification unless it is explicitly
            // retained; tracking moves it into trackedNotifications so the popup
            // Repeater can display it.
            onNotification: notif => {
                notif.tracked = true;
            }
        }
    }

    Component.onCompleted: {
        if (!Config.devMode)
            svc.server = svc._serverComponent.createObject(svc);
    }

    // The model of currently tracked notifications, for the popup Repeater.
    // Null until the server exists (and stays null in dev mode).
    readonly property var model: server ? server.trackedNotifications : null

    // ---- Shell-internal notifications --------------------------------------
    // Notifications minted by korba-shell itself (never via D-Bus / notify-send),
    // displayed alongside the D-Bus model by the popup window. These carry two
    // extra "kinds" the cards style differently:
    //   - "persistent": resident (never auto-dismisses) — for in-flight jobs
    //   - "success":    green, auto-dismisses on the Low-urgency timing
    // Held as a plain array of live objects (a ListModel can't store the
    // dismiss()/expire() methods the cards call); reassigned on every change so
    // bindings re-evaluate.
    property var internalModel: []

    // Factory for internal-notification objects. Each is a QtObject that
    // duck-types the subset of the Quickshell Notification API the cards read,
    // so a single NotificationCard delegate renders both sources unchanged.
    property Component _internalComponent: Component {
        QtObject {
            // "success" | "persistent" — drives the card accent/glyph.
            property string kind: ""
            // Urgency steers the card's auto-dismiss timeout (see urgencyTimeoutMs).
            property int urgency: NotificationUrgency.Normal
            // When true the card's timer never runs (persistent jobs stay put).
            property bool resident: false
            property string summary: ""
            property string body: ""
            property string appIcon: ""
            property string image: ""
            // No interactive actions on internal notifications.
            readonly property var actions: []

            // Both verbs just remove the notification from the model; internal
            // notifications have no D-Bus lifecycle to expire against.
            function dismiss() {
                svc._removeInternal(this);
            }
            function expire() {
                svc._removeInternal(this);
            }
        }
    }

    // Remove an internal notification and free it.
    function _removeInternal(obj) {
        var arr = svc.internalModel.slice();
        var i = arr.indexOf(obj);
        if (i < 0)
            return;
        arr.splice(i, 1);
        svc.internalModel = arr;
        obj.destroy();
    }

    // Show a green success notification that auto-dismisses on the Low-urgency
    // timing. Returns the object (rarely needed, but symmetric with persistent).
    function notifySuccess(summary, body, icon) {
        var obj = svc._internalComponent.createObject(svc, {
            "kind": "success",
            "urgency": NotificationUrgency.Low,
            "resident": false,
            "summary": summary || "",
            "body": body || "",
            "appIcon": icon || ""
        });
        var arr = svc.internalModel.slice();
        arr.push(obj);
        svc.internalModel = arr;
        return obj;
    }

    // Show a persistent (resident) notification that stays until the caller
    // dismisses it. Returns the handle: call .dismiss() when the job settles, or
    // update its .summary / .body in place to reflect progress.
    function notifyPersistent(summary, body, icon) {
        var obj = svc._internalComponent.createObject(svc, {
            "kind": "persistent",
            "urgency": NotificationUrgency.Normal,
            "resident": true,
            "summary": summary || "",
            "body": body || "",
            "appIcon": icon || ""
        });
        var arr = svc.internalModel.slice();
        arr.push(obj);
        svc.internalModel = arr;
        return obj;
    }

    // Auto-dismiss timeout for a given urgency, in milliseconds. A value of 0
    // (or less) means "never auto-dismiss" — the default for critical.
    function urgencyTimeoutMs(urgency) {
        switch (urgency) {
        case NotificationUrgency.Low:
            return Config.notificationTimeoutLow * 1000;
        case NotificationUrgency.Critical:
            return Config.notificationTimeoutCritical * 1000;
        default:
            // Normal urgency (and anything unexpected) falls here.
            return Config.notificationTimeoutNormal * 1000;
        }
    }
}
