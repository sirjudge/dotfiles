pragma ComponentBehavior: Bound
import QtNetwork
import QtQuick
import Quickshell.Io
import "../menus"
import "../../components"
import "../../services"
import "../../ConfigurationOptions"

Item {
    id: networkRoot

    property var parentShellWindow
    property var tooltipAnchor: networkRoot
    property bool isConnected: NetworkInformation.reachability !== NetworkInformation.Reachability.Disconnected
    property bool isWifi: NetworkInformation.transportMedium === NetworkInformation.TransportMedium.WiFi
    property bool isEthernet: NetworkInformation.transportMedium === NetworkInformation.TransportMedium.Ethernet
    property int signal: 0
    property string ip: ""
    property string gateway: ""
    property string ssid: ""
    property string linkRate: ""
    property bool popupOpen: false

    onIsWifiChanged: if (isWifi)
        signalProc.running = true
    onIsConnectedChanged: netInfoProc.running = true

    // While connected over WiFi, show the SSID text instead of the signal icon.
    readonly property bool showSsid: isWifi && isConnected && !connecting

    implicitWidth: showSsid ? ssidLabel.implicitWidth : networkLabel.implicitWidth
    implicitHeight: showSsid ? ssidLabel.implicitHeight : networkLabel.implicitHeight

    // True while NetworkService is bringing up a new connection.
    readonly property bool connecting: NetworkService.connecting

    MouseArea {
        id: hoverArea
        anchors.fill: parent
        hoverEnabled: true
        // Inert while connecting: the icon is a status indicator, not a button.
        cursorShape: networkRoot.connecting ? Qt.ArrowCursor : Qt.PointingHandCursor
        onClicked: {
            if (networkRoot.connecting)
                return;
            networkRoot.popupOpen = !networkRoot.popupOpen;
        }
    }

    NetworkToolTip {
        shouldShow: hoverArea.containsMouse && !networkRoot.popupOpen
        anchorItem: networkRoot.tooltipAnchor
        parentShellWindow: networkRoot.parentShellWindow
        connecting: networkRoot.connecting
        connectingSsid: NetworkService.connectingSsid
        isConnected: networkRoot.isConnected
        isWifi: networkRoot.isWifi
        ssid: networkRoot.ssid
        ip: networkRoot.ip
        gateway: networkRoot.gateway
        signal: networkRoot.signal
        linkRate: networkRoot.linkRate
    }

    NetworkPopUp {
        isOpen: networkRoot.popupOpen
        anchorItem: networkRoot.tooltipAnchor
        parentShellWindow: networkRoot.parentShellWindow
        isConnected: networkRoot.isConnected
        isWifi: networkRoot.isWifi
        isEthernet: networkRoot.isEthernet
        ssid: networkRoot.ssid
        ip: networkRoot.ip
        gateway: networkRoot.gateway
        linkRate: networkRoot.linkRate
        signal: networkRoot.signal
        onRequestClose: networkRoot.popupOpen = false
    }

    Icon {
        id: networkLabel
        anchors.centerIn: parent
        visible: !networkRoot.showSsid
        name: networkRoot.connecting ? Theme.networkConnectingIcon() : Theme.networkIcon(networkRoot.isConnected, networkRoot.isEthernet, networkRoot.signal)
        iconColor: networkRoot.connecting ? Theme.colorMuted : (networkRoot.isConnected ? Theme.colorForeground : Theme.colorMuted)

        // Spin the sync glyph while a connection attempt is in flight.
        RotationAnimator {
            target: networkLabel
            running: networkRoot.connecting
            from: 0
            to: 360
            duration: 1000
            loops: Animation.Infinite
            onRunningChanged: if (!running)
                networkLabel.rotation = 0
        }
    }

    ShellText {
        id: ssidLabel
        anchors.centerIn: parent
        visible: networkRoot.showSsid
        text: networkRoot.ssid
    }

    // Polls only while on WiFi; onIsWifiChanged also kicks an immediate read.
    PolledProcess {
        id: signalProc
        interval: 5000
        enabled: networkRoot.isWifi
        command: ["cat", "/proc/net/wireless"]
        onRead: data => {
            var match = data.match(/^\s*\S+:\s+\S+\s+(\d+)/);
            if (match)
                networkRoot.signal = Math.min(100, Math.round(parseInt(match[1]) / 70 * 100));
        }
    }

    PolledProcess {
        id: netInfoProc
        interval: 10000
        command: ["sh", "-c",
            // Parse gateway, interface name, and source IP from the default route in one awk pass
            "route=$(ip -4 route show default | awk 'NR==1{gw=\"-\";dev=\"-\";src=\"-\";for(i=1;i<=NF;i++){if($i==\"via\")gw=$(i+1);if($i==\"dev\")dev=$(i+1);if($i==\"src\")src=$(i+1)}print gw \"|\" dev \"|\" src}'); " +
            // Unpack the three pipe-separated route fields
            "gw=${route%%|*}; tmp=${route#*|}; iface=${tmp%%|*}; ip=${tmp##*|}; " +
            // Get active SSID and link rate in one nmcli call; parse SSID left-to-right and RATE from the right to handle colons in SSIDs
            "wifi=$(nmcli -t -f ACTIVE,SSID,RATE dev wifi 2>/dev/null | awk -F: '/^yes:/{r=$NF; s=\"\"; for(i=2;i<NF;i++){if(i>2)s=s\":\"; s=s$i}; split(r,a,\" \"); if(a[1]+0>0)r=sprintf(\"%g %s\",a[1],a[2]); else r=\"\"; printf \"%s|%s\",s,r; exit}'); " +
            // Unpack SSID and rate from the awk output
            "ssid=${wifi%|*}; rate=${wifi##*|}; " +
            // Fall back to /sys link speed (reliable for Ethernet; WiFi drivers rarely populate this)
            "[ -z \"$rate\" ] && rate=$(cat \"/sys/class/net/$iface/speed\" 2>/dev/null | awk '{if($1+0>0)printf \"%d Mbit/s\",$1}'); " +
            // Output: ip|gateway|ssid|rate
            "printf \"%s|%s|%s|%s\" \"$ip\" \"$gw\" \"$ssid\" \"$rate\""]
        onRead: data => {
            if (!data.trim())
                return;
            var parts = data.trim().split("|");
            networkRoot.ip = parts[0] ?? "";
            networkRoot.gateway = parts[1] ?? "";
            networkRoot.ssid = parts[2] ?? "";
            networkRoot.linkRate = parts[3] ?? "";
        }
    }
}

