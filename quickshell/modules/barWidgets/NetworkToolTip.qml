pragma ComponentBehavior: Bound
import "../../components"
import "../../ConfigurationOptions"

ColumnToolTip {
    id: tooltipRoot

    property bool connecting: false
    property string connectingSsid: ""
    property bool isConnected: false
    property bool isWifi: false
    property string ssid: ""
    property string ip: ""
    property string gateway: ""
    property int signal: 0
    property string linkRate: ""

    spacing: Theme.spacingSmall

    ShellText {
        id: headerText
        color: Theme.colorForeground
        text: {
            if (tooltipRoot.connecting)
                return "Connecting to " + (tooltipRoot.connectingSsid || "network") + "...";
            if (!tooltipRoot.isConnected)
                return "Disconnected";
            if (tooltipRoot.isWifi)
                return tooltipRoot.ssid || "WiFi";
            return "Ethernet";
        }
    }

    Divider {
        visible: tooltipRoot.isConnected && !tooltipRoot.connecting
        width: Math.max(headerText.implicitWidth, detailText.implicitWidth, statsText.implicitWidth)
        color: Theme.colorForeground
    }

    ShellText {
        id: detailText
        visible: tooltipRoot.isConnected && !tooltipRoot.connecting
        color: Theme.colorForeground
        text: "IP: " + (tooltipRoot.ip || "—") + "\nGateway: " + (tooltipRoot.gateway || "—")
    }

    ShellText {
        id: statsText
        visible: tooltipRoot.isConnected && !tooltipRoot.connecting && (tooltipRoot.isWifi || tooltipRoot.linkRate !== "")
        color: Theme.colorMuted
        text: {
            var parts = [];
            if (tooltipRoot.isWifi && tooltipRoot.signal > 0)
                parts.push("Signal: " + tooltipRoot.signal + "%");
            if (tooltipRoot.linkRate)
                parts.push(tooltipRoot.linkRate);
            return parts.join("  ·  ");
        }
    }
}
