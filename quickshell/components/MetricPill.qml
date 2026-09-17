pragma ComponentBehavior: Bound
import QtQuick
import "../components"
import "../ConfigurationOptions"

// An independent alert pill rendered outside the island (top-right corner). Its
// background colour reflects the metric's criticality — the error / warning fill
// once `value` crosses the matching threshold, otherwise the neutral island
// surface — with a label colour chosen for contrast against that fill. Shares the
// island's height, corner radius and opacity so the pills read as a consistent
// family. Set `text` to the full label.
Rectangle {
    id: pill

    property int value: 0
    property string text: ""
    // Thresholds default out of range so an unset metric never trips them.
    property int warning: 101
    property int critical: 101

    readonly property bool isCritical: value >= critical
    readonly property bool isWarning: !isCritical && value >= warning

    implicitWidth: label.implicitWidth + 2 * Theme.paddingH
    // Full bar height so the pill lines up with, and matches, the island.
    implicitHeight: Config.barHeight

    radius: Theme.cornerRadius
    opacity: Theme.backgroundOpacity
    color: isCritical ? Theme.colorError : (isWarning ? Theme.colorWarning : Theme.colorBackground)

    ShellText {
        id: label
        anchors.centerIn: parent
        text: pill.text
        // Dark text on the bright alert fills; the normal foreground otherwise.
        color: (pill.isCritical || pill.isWarning) ? Theme.colorBackground : Theme.colorForeground
        bold: true
    }
}

