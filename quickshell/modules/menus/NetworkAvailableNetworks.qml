pragma ComponentBehavior: Bound
import QtQuick
import "../../components"
import "../../ConfigurationOptions"

// Fills the height it is given: a fixed header row on top and the network list
// filling the rest. The list viewport never changes size, so rescans (which
// clear and repopulate the list) don't resize anything — the "Refreshing…"
// indicator is overlaid in place instead of collapsing the list.
Item {
    id: networksRoot

    property var networks: []
    property bool scanning: false
    property string currentSsid: ""
    // SSIDs NetworkManager already has saved profiles for.
    property var knownNetworks: []

    signal refreshRequested
    signal connectToNetwork(string ssid, bool isSecured, string security)
    signal forgetNetwork(string ssid)

    Row {
        id: networksHeader
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        ShellText {
            id: networksLabel
            anchors.verticalCenter: parent.verticalCenter
            text: "Available Networks"
            color: Theme.colorForeground
            bold: true
        }

        Item {
            width: networksHeader.width - networksLabel.width - refreshBtn.width
            height: 1
        }

        Icon {
            id: refreshBtn
            anchors.verticalCenter: parent.verticalCenter
            name: "sync"
            iconColor: networksRoot.scanning ? Theme.colorMuted : (refreshArea.containsMouse ? Theme.colorHighlight : Theme.colorForeground)

            MouseArea {
                id: refreshArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: networksRoot.refreshRequested()
            }
        }
    }

    Item {
        id: listContainer
        anchors {
            top: networksHeader.bottom
            topMargin: Theme.spacingSmall
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        clip: true

        ListView {
            id: networkListView
            anchors.fill: parent
            visible: !networksRoot.scanning
            model: networksRoot.networks.filter(n => n.ssid !== networksRoot.currentSsid)
            spacing: 2

            delegate: WifiNetworkRow {
                required property var modelData
                width: networkListView.width
                networkData: modelData
                isKnown: networksRoot.knownNetworks.indexOf(modelData.ssid) >= 0
                onConnectRequested: ssid => {
                    var net = modelData;
                    var secured = net.security && net.security !== "--" && net.security !== "";
                    networksRoot.connectToNetwork(ssid, secured, net.security ?? "");
                }
                onForgetRequested: ssid => networksRoot.forgetNetwork(ssid)
            }
        }

        // Overlaid (not in the layout) so a rescan keeps the viewport fixed.
        Row {
            anchors.centerIn: parent
            visible: networksRoot.scanning
            spacing: Theme.spacingSmall

            Icon {
                name: "sync"
                iconColor: Theme.colorMuted
            }

            ShellText {
                text: "Refreshing..."
                color: Theme.colorMuted
            }
        }
    }
}
