pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Hyprland
import QtQuick
import "../../ConfigurationOptions"

Row {
    id: workspacesRoot
    required property ShellScreen screen
    property HyprlandMonitor topLevelMonitor: Hyprland.monitorFor(workspacesRoot.screen)
    property var workspaces: Hyprland.workspaces.values.filter(
        w => topLevelMonitor.id === w.monitor?.id
    );

    spacing: Theme.spacingMedium

    Repeater {
        model: workspacesRoot.workspaces

        Item {
            id: workspaceItem
            required property HyprlandWorkspace modelData
            
            property bool isActive: Hyprland.monitors.values.some(
                m => m.activeWorkspace?.id === modelData.id
            )

            readonly property int dotSize: 20
            // Taller invisible hit area than the dot itself so the click target is
            // easier to land on without enlarging the visual indicator.
            readonly property int hitHeight: 25

            width: indicator.width
            height: hitHeight
            anchors.verticalCenter: parent.verticalCenter

            Rectangle {
                id: indicator
                anchors.centerIn: parent
                height: workspaceItem.dotSize
                width: workspaceItem.isActive ? workspaceItem.dotSize * 2 : workspaceItem.dotSize
                radius: height / 2
                color: workspaceItem.isActive ? Theme.rosePineFoam : Theme.rosePinePine
                Behavior on width {
                    NumberAnimation {
                        duration: 150
                        easing.type: Easing.OutCubic
                    }
                }
                Text { 
                    anchors.centerIn: parent
                    id: workspaceNumber
                    text:workspaceItem.modelData.id
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                // Hyprland 0.55.x evaluates dispatch strings as Lua, so the legacy
                // "workspace N" syntax fails; focus the workspace via the Lua
                // dispatcher hl.dsp.focus({ workspace = N }).
                onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + workspaceItem.modelData.id + " })")
            }
        }
    }
}

