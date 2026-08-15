pragma ComponentBehavior: Bound
import QtQuick
import "../ConfigurationOptions"

// Shared Text carrying the shell's default typography: the sans-serif prose
// face at the theme size, in the foreground colour. Drop-in for Text — override
// `color` or `font.pixelSize` as needed, and use the conveniences:
//   bold:  true   — emphasised weight
//   muted: true   — the muted (low-emphasis) colour
Text {
    property bool bold: false
    property bool muted: false

    color: muted ? Theme.colorMuted : Theme.colorForeground
    font.family: Theme.fontFamilySans
    font.pixelSize: Theme.fontSize
    font.weight: bold ? Theme.fontWeightBold : Theme.fontWeight
}
