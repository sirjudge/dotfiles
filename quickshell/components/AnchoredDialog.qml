pragma ComponentBehavior: Bound
import QtQuick
import "../ConfigurationOptions"

// An AnchoredPopup variant for the interactive dialogs the user opens from the
// island (network, volume). Instead of the tooltip fade + slide, it unrolls:
// the content is clipped to a height that grows from the top edge, so the panel
// rolls down from the island on open and rolls back up on close, like a window
// shade. The motion is intentionally slower and more deliberate than a tooltip.
AnchoredPopup {
    id: dialog

    // Slower, smoother timing than the default tooltip pop, so the roll reads as
    // a deliberate gesture rather than a flash.
    enterDuration: 360
    exitDuration: 300
    enterEasing: Easing.OutQuint
    exitEasing: Easing.InQuint

    // The base neither draws a background nor fades/slides its own wrapper — the
    // clipper below provides the rounded panel and drives the whole reveal off
    // animProgress.
    showBackground: false
    animateContent: false

    // Consumer content is placed into the full-size body inside the clipper.
    default property alias dialogContent: body.data

    // `content` is AnchoredPopup's default property: this clipper is the base's
    // content. Its height grows from the top as animProgress rises (rolling
    // down) and shrinks back on close (rolling up); `body` is pinned to the full
    // dialog height inside it so the content never squashes — only the revealed
    // slice shows, and the flat bottom clip line reads as the unrolling edge.
    content: Item {
        id: clipper
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: Math.round(dialog.animProgress * dialog.height)
        clip: true

        Item {
            id: body
            width: clipper.width
            height: dialog.height

            Rectangle {
                anchors.fill: parent
                color: Theme.colorBackground
                opacity: Theme.backgroundOpacity
                radius: Theme.cornerRadius
            }
        }
    }
}
