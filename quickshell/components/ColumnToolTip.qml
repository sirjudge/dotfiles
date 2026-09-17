pragma ComponentBehavior: Bound
import QtQuick
import "../ConfigurationOptions"

// A tooltip whose body is a vertical stack of rows. Declare the rows as
// children and they go into the centered column; content sizing comes for free
// (mirrors how TextTooltip wraps the single-line case). Override `spacing` to
// taste.
ToolTipWindow {
    default property alias content: tooltipCol.data
    property alias spacing: tooltipCol.spacing

    contentWidth: tooltipCol.implicitWidth + Theme.paddingH
    contentHeight: tooltipCol.implicitHeight + Theme.paddingV

    Column {
        id: tooltipCol
        anchors.centerIn: parent
        spacing: Theme.popupGap
    }
}

