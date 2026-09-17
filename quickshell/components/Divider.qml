pragma ComponentBehavior: Bound
import QtQuick
import "../ConfigurationOptions"

// A hairline divider rule. By default a horizontal rule: set `width` (or let it
// fill) and optionally override `color`. Set `vertical: true` for a vertical
// rule and give it a `height`. The thinness and translucency are shared across
// the shell.
Rectangle {
    property bool vertical: false

    color: Theme.colorMuted
    opacity: Theme.dividerOpacity
    implicitWidth: vertical ? 1 : 0
    implicitHeight: vertical ? 0 : 1
}
