import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Hyprland
import "../"
import "barWidgets" as Widgets
import "../ConfigurationOptions"
import "../components"

ShellRoot {
    Variants {
        model: Quickshell.screens

        PanelWindow {
          required property var modelData
          screen: modelData
          id: root

          property string fontFamily: "JetBrainsMono Nerd Font"
          property int fontSize: 20

          implicitHeight: 30
          color: Theme.rosePineBase

          anchors {
            top: true
            left: true
            right: true
          }
     

          Widgets.TimeDisplay {
              anchors.centerIn: parent
              color: Theme.rosePineText
          }

          Row {
              Widgets.Workspaces {
                  screen: root.screen 
              }
          }

          Row {
              id: metricsRow
              anchors {
                  right: parent.right
                  verticalCenter: parent.verticalCenter
              }
              spacing: 10
              Widgets.Network {}
              Divider {
                  width: 10
                  color: Theme.colorForeground
              }
              Widgets.MemoryUsage {}
              Widgets.CpuUsage {}
          }
      }
    }
}
