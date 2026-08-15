pragma ComponentBehavior: Bound
import QtQuick
import "../../components"
import "../../ConfigurationOptions"

Item {
    id: wifiRow

    required property var networkData
    // True when NetworkManager already has a saved profile for this SSID.
    property bool isKnown: false
    // True while the Forget pill is shown (known network, row/button hovered).
    readonly property bool forgetVisible: isKnown && (rowHover.containsMouse || forgetArea.containsMouse)

    signal connectRequested(string ssid)
    signal forgetRequested(string ssid)

    implicitHeight: rowContent.implicitHeight + 8

    Rectangle {
        anchors.fill: parent
        radius: Theme.cornerRadiusSmall
        color: rowHover.containsMouse ? Theme.colorHover : "transparent"
    }

    MouseArea {
        id: rowHover
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: wifiRow.connectRequested(wifiRow.networkData.ssid)
    }

    Row {
        id: rowContent
        anchors {
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
            margins: Theme.spacingTiny
        }
        spacing: Theme.spacingMedium

        Icon {
            id: signalIcon
            anchors.verticalCenter: parent.verticalCenter
            name: Theme.wifiIcon(wifiRow.networkData.signal)
            iconColor: Theme.colorForeground
        }

        ShellText {
            id: ssidText
            anchors.verticalCenter: parent.verticalCenter
            width: rowContent.width - signalIcon.width - secBadge.width - freqText.width - rowContent.spacing * 3
            text: wifiRow.networkData.ssid
            // Known networks stand out in the highlight color.
            color: wifiRow.isKnown ? Theme.colorHighlight : Theme.colorForeground
            font {
                pixelSize: Theme.fontSize
                bold: wifiRow.isKnown
            }
            elide: Text.ElideRight
        }

        ShellText {
            id: secBadge
            anchors.verticalCenter: parent.verticalCenter
            // Hidden while the Forget pill covers this area, to avoid overlap.
            visible: !wifiRow.forgetVisible
            text: {
                var s = wifiRow.networkData.security;
                if (!s || s === "--" || s === "")
                    return "Open";
                if (s.includes("WPA3"))
                    return "WPA3";
                if (s.includes("WPA2"))
                    return "WPA2";
                if (s.includes("WPA"))
                    return "WPA";
                return s;
            }
            color: Theme.colorMuted
            font {
                pixelSize: Theme.fontSize - 2
            }
        }

        ShellText {
            id: freqText
            anchors.verticalCenter: parent.verticalCenter
            // Hidden while the Forget pill covers this area, to avoid overlap.
            visible: !wifiRow.forgetVisible
            text: Theme.freqBand(wifiRow.networkData.freq)
            color: Theme.colorMuted
            font {
                pixelSize: Theme.fontSize - 2
            }
        }
    }

    // "Forget" pill, revealed on hover for known networks. Overlaid on the right
    // (over the security/frequency badges) so showing it doesn't reflow the row.
    Rectangle {
        id: forgetBtn
        // Shown while the row or the button itself is hovered (the button's own
        // MouseArea takes hover away from the row underneath).
        visible: wifiRow.forgetVisible
        anchors {
            right: parent.right
            rightMargin: Theme.spacingTiny
            verticalCenter: parent.verticalCenter
        }
        width: forgetLabel.implicitWidth + 16
        height: forgetLabel.implicitHeight + 6
        radius: height / 2
        // Opaque fill masks the badges underneath; tints red on hover.
        color: forgetArea.containsMouse ? Theme.withAlpha(Theme.colorError, 0.2) : Theme.colorBackground
        border {
            color: Theme.colorError
            width: 1
        }

        ShellText {
            id: forgetLabel
            anchors.centerIn: parent
            text: "Forget"
            color: Theme.colorError
            font.pixelSize: Theme.fontSize - 2
        }

        MouseArea {
            id: forgetArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            // Consume the click so it doesn't fall through to the row's connect.
            onClicked: wifiRow.forgetRequested(wifiRow.networkData.ssid)
        }
    }
}
