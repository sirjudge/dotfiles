
pragma ComponentBehavior: Bound
import QtQuick
import "../../components"
import "../../ConfigurationOptions"

Item {
    id: detailsRoot

    property bool isWifi: false
    property string ip: ""
    property string gateway: ""
    property string dns: ""
    property string linkRate: ""
    property int signal: 0
    property string currentFreq: ""

    // Fixed width of the left label column so the value column aligns across rows.
    readonly property int labelWidth: 72

    implicitHeight: detailsCol.implicitHeight

    Column {
        id: detailsCol
        width: parent.width
        spacing: Theme.spacingTiny

        Row {
            width: parent.width
            spacing: Theme.spacingMedium

            ShellText {
                width: detailsRoot.labelWidth
                text: "IP"
                color: Theme.colorMuted
            }

            ShellText {
                text: detailsRoot.ip || "—"
                color: Theme.colorForeground
            }
        }

        Row {
            width: parent.width
            spacing: Theme.spacingMedium

            ShellText {
                width: detailsRoot.labelWidth
                text: "Gateway"
                color: Theme.colorMuted
            }

            ShellText {
                text: detailsRoot.gateway || "—"
                color: Theme.colorForeground
            }
        }

        // DNS / Speed / Frequency are always laid out (showing "—" until their
        // async values arrive) so the details block keeps a constant height per
        // connection type and the popup never resizes as data populates.
        Row {
            width: parent.width
            spacing: Theme.spacingMedium

            ShellText {
                width: detailsRoot.labelWidth
                text: "DNS"
                color: Theme.colorMuted
            }

            ShellText {
                text: detailsRoot.dns || "—"
                color: Theme.colorForeground
                wrapMode: Text.NoWrap
                elide: Text.ElideRight
                width: detailsRoot.width - 72 - 8
            }
        }

        Row {
            width: parent.width
            spacing: Theme.spacingMedium

            ShellText {
                width: detailsRoot.labelWidth
                text: "Speed"
                color: Theme.colorMuted
            }

            ShellText {
                text: detailsRoot.linkRate || "—"
                color: Theme.colorForeground
            }
        }

        Row {
            visible: detailsRoot.isWifi
            height: visible ? implicitHeight : 0
            width: parent.width
            spacing: Theme.spacingMedium

            ShellText {
                width: detailsRoot.labelWidth
                text: "Signal"
                color: Theme.colorMuted
            }

            ShellText {
                text: detailsRoot.signal + "%"
                color: Theme.colorForeground
            }
        }

        Row {
            visible: detailsRoot.isWifi
            height: visible ? implicitHeight : 0
            width: parent.width
            spacing: Theme.spacingMedium

            ShellText {
                width: detailsRoot.labelWidth
                text: "Frequency"
                color: Theme.colorMuted
            }

            ShellText {
                text: detailsRoot.currentFreq !== "" ? Theme.freqBand(detailsRoot.currentFreq) : "—"
                color: Theme.colorForeground
            }
        }
    }
}
