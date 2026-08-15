pragma ComponentBehavior: Bound
import Quickshell.Io
import QtQuick

// A Process re-run on a fixed interval. Set `command` and (optionally)
// `interval`; consume output via the `read` signal. While `enabled` it runs
// once on load and then every `interval` ms. Set `enabled: false` to keep it
// idle (e.g. when a sensor path is unconfigured).
Process {
    id: proc

    property int interval: 2000
    property bool enabled: true

    // Emitted for each line parsed from stdout.
    signal read(string data)

    stdout: SplitParser {
        onRead: data => proc.read(data)
    }

    Component.onCompleted: if (proc.enabled)
        running = true

    // Held in a property because Process (not being an Item) has no default
    // property to parent a child Timer into.
    property var _timer: Timer {
        interval: proc.interval
        running: proc.enabled
        repeat: true
        onTriggered: proc.running = true
    }
}

