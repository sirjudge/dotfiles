pragma ComponentBehavior: Bound
import Quickshell.Hyprland
import QtQuick
import "../../ConfigurationOptions"

// Background-less workspace switcher; sits directly on the island surface.
Row {
    id: workspacesRoot
    property var workspaceIds: [1, 2, 3, 4]

    spacing: Colors.spacingMedium

    Repeater {
        model: workspacesRoot.workspaceIds

        // A small filled dot for inactive workspaces; the focused one stretches
        // into a pill. Same color structure as the previous numeric labels.
        Item {
            id: workspaceItem
            required property int modelData
            property var ws: Hyprland.workspaces.values.find(w => w.id === modelData)
            property bool isActive: Hyprland.monitors.values.some(m => m.activeWorkspace?.id === modelData)

            readonly property int dotSize: 12
            // Taller invisible hit area than the dot itself so the click target is
            // easier to land on without enlarging the visual indicator.
            readonly property int hitHeight: 16

            width: indicator.width
            height: hitHeight
            anchors.verticalCenter: parent.verticalCenter

            Rectangle {
                id: indicator
                anchors.centerIn: parent
                height: workspaceItem.dotSize
                // Focused workspace becomes an elongated pill; others stay round.
                width: workspaceItem.isActive ? workspaceItem.dotSize * 3 : workspaceItem.dotSize
                radius: height / 2
                color: workspaceItem.isActive ? Colors.rosePineFoam : Colors.rosePinePine
                Behavior on width {
                    NumberAnimation {
                        duration: 150
                        easing.type: Easing.OutCubic
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                // Hyprland 0.55.x evaluates dispatch strings as Lua, so the legacy
                // "workspace N" syntax fails; focus the workspace via the Lua
                // dispatcher hl.dsp.focus({ workspace = N }).
                onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + workspaceItem.modelData + " })")
            }
        }
    }
}

