pragma ComponentBehavior: Bound
import QtQuick
import "../ConfigurationOptions"

// Renders a single Google Material Symbols glyph by ligature name (e.g.
// `name: "wifi"`). Use this for ALL icons; use ShellText for prose/labels.
// Override `iconColor` or `font.pixelSize` as needed.
Text {
    property string name: ""
    property color iconColor: Theme.colorForeground

    property int weight: Theme.iconWeight

    text: name
    color: iconColor
    font.family: Theme.fontFamilyIcon
    font.pixelSize: Theme.iconSize
    // Drive the Material Symbols `wght` variable-font axis to control stroke thickness.
    font.variableAxes: ({
            wght: weight
        })
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
}

