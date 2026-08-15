pragma ComponentBehavior: Bound
import QtQuick
import "../../components"
import "../../ConfigurationOptions"

MetricPill {
    id: cpuRoot

    property int cpuUsage: 0
    property real prevIdle: 0
    property real prevTotal: 0

    value: cpuUsage
    text: cpuUsage + "% cpu used"
    warning: Config.cpuWarning
    critical: Config.cpuCritical
    visible: cpuUsage >= Config.cpuDisplayFrom

    PolledProcess {
        command: ["sh", "-c", "grep '^cpu ' /proc/stat"]
        onRead: data => {
            if (!data)
                return;
            var parts = data.trim().split(/\s+/).slice(1).map(Number);
            var idle = parts[3] + parts[4];
            var total = parts.reduce((a, b) => a + b, 0);

            var idleDelta = idle - cpuRoot.prevIdle;
            var totalDelta = total - cpuRoot.prevTotal;

            if (cpuRoot.prevTotal > 0 && totalDelta > 0)
                cpuRoot.cpuUsage = Math.round(100 * (totalDelta - idleDelta) / totalDelta);

            cpuRoot.prevIdle = idle;
            cpuRoot.prevTotal = total;
        }
    }
}
