import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Hyprland
import "../"
import "barWidgets" as Widgets

ShellRoot {
    Variants {
        model: Quickshell.screens

        PanelWindow {
          required property var modelData
          screen: modelData
          id: root

          property string fontFamily: "JetBrainsMono Nerd Font"
          property int fontSize: 14

          color: ColorOptions.rosePineBase

          anchors {
            top: true
            left: true
            right: true
          }
     
          implicitHeight: 30

          Widgets.TimeDisplay {
            anchors.centerIn: parent
            color: ColorOptions.rosePineText
          }

          Widgets.Workspaces {}
      }
    }
}
