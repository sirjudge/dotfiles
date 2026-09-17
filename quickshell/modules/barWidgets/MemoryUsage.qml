pragma ComponentBehavior: Bound
import QtQuick
import "../../components"
import "../../ConfigurationOptions"

MetricPill {
    id: memRoot

    property int memUsage: 0

    value: memUsage
    text: memUsage + "% memory used"
    warning: Config.memoryWarning
    critical: Config.memoryCritical
    visible: memUsage >= Config.memoryDisplayFrom

    PolledProcess {
        command: ["sh", "-c", "free | grep Mem"]
        onRead: data => {
            if (!data)
                return;
            var parts = data.trim().split(/\s+/);
            var total = parseInt(parts[1]);
            var used = parseInt(parts[2]);
            memRoot.memUsage = Math.round(100 * used / total);
        }
    }
}


