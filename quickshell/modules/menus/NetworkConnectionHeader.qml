pragma ComponentBehavior: Bound
import QtQuick
import "../../components"
import "../../ConfigurationOptions"

Item {
    id: headerRoot

    property bool isConnected: false
    property bool isWifi: false
    property bool isEthernet: false
    property string ssid: ""
    property int signal: 0
    property bool wifiEnabled: false

    signal toggleWifiRequested
    signal disconnectRequested

    implicitHeight: headerRow.implicitHeight

    Row {
        id: headerRow
        width: parent.width

        Row {
            id: headerLeft
            spacing: Theme.spacingSmall
            anchors.verticalCenter: parent.verticalCenter

            Icon {
                anchors.verticalCenter: parent.verticalCenter
                name: Theme.networkIcon(headerRoot.isConnected, headerRoot.isEthernet, headerRoot.signal)
                iconColor: headerRoot.isConnected ? Theme.colorForeground : Theme.colorMuted
            }

            ShellText {
                anchors.verticalCenter: parent.verticalCenter
                text: {
                    if (!headerRoot.isConnected)
                        return "Disconnected";
                    if (headerRoot.isEthernet)
                        return "Ethernet";
                    return headerRoot.ssid || "";
                }
                color: headerRoot.isConnected ? Theme.colorForeground : Theme.colorMuted
                bold: true
            }
        }

        Item {
            width: headerRow.width - headerLeft.width - rightControls.width
            height: 1
        }

        Row {
            id: rightControls
            anchors.verticalCenter: parent.verticalCenter
            spacing: Theme.spacingMedium

            Item {
                id: disconnectBtn
                visible: headerRoot.isWifi && headerRoot.isConnected
                width: visible ? disconnectBtnText.implicitWidth + 16 : 0
                height: disconnectBtnText.implicitHeight + 6

                Rectangle {
                    anchors.fill: parent
                    radius: height / 2
                    color: disconnectArea.containsMouse ? Theme.withAlpha(Theme.colorHighlightAlt, 0.2) : "transparent"
                    border {
                        color: Theme.colorHighlightAlt
                        width: 1
                    }
                }

                ShellText {
                    id: disconnectBtnText
                    anchors.centerIn: parent
                    text: "Disconnect"
                    color: Theme.colorHighlightAlt
                    font {
                        pixelSize: Theme.fontSize - 2
                    }
                }

                MouseArea {
                    id: disconnectArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: headerRoot.disconnectRequested()
                }
            }

            Rectangle {
                id: toggleBtn
                anchors.verticalCenter: parent.verticalCenter
                visible: headerRoot.isWifi || !headerRoot.isConnected
                width: visible ? 36 : 0
                height: 20
                radius: height / 2
                color: headerRoot.wifiEnabled ? Theme.colorHighlight : Theme.colorMuted
                opacity: toggleBtnArea.containsMouse ? 0.8 : 1.0

                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }

                Rectangle {
                    width: 16
                    height: 16
                    radius: height / 2
                    anchors.verticalCenter: parent.verticalCenter
                    x: headerRoot.wifiEnabled ? parent.width - width - 2 : 2
                    color: Theme.colorBackground

                    Behavior on x {
                        NumberAnimation {
                            duration: 100
                            easing.type: Easing.OutCubic
                        }
                    }
                }

                MouseArea {
                    id: toggleBtnArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: headerRoot.toggleWifiRequested()
                }
            }
        }
    }
}
