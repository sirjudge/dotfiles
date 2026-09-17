pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Hyprland
import QtQuick
import "../ConfigurationOptions"

// Base for every popup/tooltip that drops down from a bar widget: it owns the
// shared enter/exit animation, the anchoring to the bar window, and (optionally)
// the rounded translucent background. Consumers set `anchorItem`,
// `parentShellWindow` and `isOpen`, set `contentWidth`/`contentHeight` to their
// content's size, then declare their content as children — it is placed above
// the background and animated together with it.
//
// Interactive popups should set `wantsFocus: true` and put their key handling on
// a focusable child of their content. We deliberately do NOT use PopupWindow's
// native `grabFocus`: it hides the window the instant a click lands outside,
// which skips the exit animation. Instead a HyprlandFocusGrab keeps the window
// mapped and merely emits `cleared`, so an outside click animates closed exactly
// like an Esc press (both route through requestClose).
PopupWindow {
    id: popup

    property var anchorItem
    property var parentShellWindow
    property bool isOpen: false
    // Current scale of the island the anchor item sits inside (1.0 = condensed).
    // Defaults to the host bar window's islandScale so tooltips/popups drop below
    // the island's *visual* bottom when it is hover-zoomed; windows without that
    // property (greeter, session, …) fall back to 1.0.
    property real islandScale: parentShellWindow?.islandScale ?? 1.0
    // Whether this popup takes keyboard focus and dismisses on an outside click
    // (via the HyprlandFocusGrab below). Tooltips leave this false.
    property bool wantsFocus: false
    property real animProgress: 0
    // True only while resizeRefresh is hiding/recreating the surface after a
    // content resize; lets onVisibleChanged tell that transient hide apart from a
    // genuine close so it doesn't emit requestClose.
    property bool refreshing: false
    // When false, the consumer draws its own background (e.g. a rounded-clipped
    // layer); otherwise the standard translucent panel is provided here.
    property bool showBackground: true
    // When false, the content wrapper applies no fade/slide and the consumer
    // animates `animProgress` itself (e.g. through a MultiEffect composite).
    property bool animateContent: true

    // Enter/exit timing for the shared animProgress animation. Defaults match the
    // global Theme values (so tooltips are unchanged); subclasses such as
    // AnchoredDialog override these for a slower, more deliberate motion.
    property int enterDuration: Theme.animEnter
    property int exitDuration: Theme.animExit
    property int enterEasing: Easing.OutCubic
    property int exitEasing: Easing.InCubic

    // The popup's content size.
    property int contentWidth: 0
    property int contentHeight: 0

    // The size actually handed to the window. It mirrors the content size, except
    // it is *held at the old size* while resizeRefresh fades the popup out and
    // hides it — the new size is adopted only once the window is hidden. Shrinking
    // a visible PopupWindow strands a ghost of the old size (the compositor keeps
    // the larger surface), so the resize must happen while there is nothing on
    // screen, exactly as it does for an open/close. Plain (non-bound) so the size
    // can be held; syncSize() keeps them current.
    property int renderWidth: 0
    property int renderHeight: 0

    implicitWidth: renderWidth
    implicitHeight: renderHeight

    Component.onCompleted: syncSize()

    default property alias content: contentWrapper.data

    signal requestClose

    onIsOpenChanged: {
        resizeRefresh.stop();
        refreshing = false;
        if (isOpen) {
            exitAnim.stop();
            visible = true;
            enterAnim.start();
        } else {
            enterAnim.stop();
            exitAnim.start();
        }
    }

    onVisibleChanged: if (!visible && isOpen && !refreshing)
        requestClose()

    // Dismiss-on-outside-click for interactive popups, without the native
    // grabFocus auto-hide. The grab is held only while the popup is genuinely on
    // screen (not during the resizeRefresh blink); clicking outside emits
    // `cleared`, which closes through the animated path.
    HyprlandFocusGrab {
        active: popup.wantsFocus && popup.isOpen && popup.visible && !popup.refreshing
        windows: [popup]
        onCleared: if (popup.isOpen)
            popup.requestClose()
    }

    // Keep renderWidth/Height in step with the content size. While hidden or
    // mid-open the new size is adopted directly; while fully shown it is deferred
    // to resizeRefresh so the window never shrinks on screen (see renderWidth).
    onContentWidthChanged: syncSize()
    onContentHeightChanged: syncSize()

    function syncSize() {
        if (isOpen && visible && animProgress >= 1) {
            if ((renderWidth !== contentWidth || renderHeight !== contentHeight) && !resizeRefresh.running)
                resizeRefresh.start();
        } else {
            renderWidth = contentWidth;
            renderHeight = contentHeight;
        }
    }

    SequentialAnimation {
        id: resizeRefresh

        // Fade the (old-size) popup out, hide it, adopt the new size while nothing
        // is on screen, then bring it back in. Keeping `visible` false across a
        // real pause (not a synchronous toggle) is what forces the compositor to
        // drop the stale surface.
        ScriptAction {
            script: popup.refreshing = true
        }
        NumberAnimation {
            target: popup
            property: "animProgress"
            from: 1
            to: 0
            duration: Theme.animExit
            easing.type: Easing.InCubic
        }
        ScriptAction {
            script: {
                popup.visible = false;
                popup.renderWidth = popup.contentWidth;
                popup.renderHeight = popup.contentHeight;
            }
        }
        PauseAnimation {
            duration: 32
        }
        ScriptAction {
            script: {
                popup.visible = true;
                popup.refreshing = false;
            }
        }
        NumberAnimation {
            target: popup
            property: "animProgress"
            from: 0
            to: 1
            duration: Theme.animEnter
            easing.type: Easing.OutCubic
        }
    }

    NumberAnimation {
        id: enterAnim
        target: popup
        property: "animProgress"
        from: 0
        to: 1
        duration: popup.enterDuration
        easing.type: popup.enterEasing
    }

    NumberAnimation {
        id: exitAnim
        target: popup
        property: "animProgress"
        from: 1
        to: 0
        duration: popup.exitDuration
        easing.type: popup.exitEasing
        onStopped: if (!popup.isOpen)
            popup.visible = false
    }

    anchor.window: parentShellWindow
    anchor.item: anchorItem
    anchor.edges: Edges.Bottom
    anchor.gravity: Edges.Bottom
    // Drop the popup just below the island with a small gap, regardless of which
    // widget triggered it. Every anchor target (the island, and each widget via
    // Layout.alignment VCenter) is vertically centred within the island, which is
    // Config.barHeight tall and pinned to the window top, then scaled by islandScale
    // about its top edge. So an anchor item's bottom edge sits at
    // (barHeight + item.height) / 2 * islandScale in window coordinates, and the
    // island's visual bottom at barHeight * islandScale; the difference, minus the
    // gap, drops the popup just past the (possibly zoomed) island bottom. The
    // popup's top is placed at the item's bottom minus this margin, so a negative
    // margin pushes it below. (Using anchorItem.y here would be wrong: it is relative
    // to the item's layout parent, not the window, so tooltips would land inside the
    // island.) With islandScale 1.0 this reduces to the original condensed-bar form.
    anchor.margins.bottom: anchorItem ? Math.round((anchorItem.height - Config.barHeight) / 2 * islandScale) - Theme.popupGap : 0
    color: "transparent"

    Item {
        id: contentWrapper
        anchors.fill: parent
        opacity: popup.animateContent ? popup.animProgress : 1.0
        transform: Translate {
            y: popup.animateContent ? (1 - popup.animProgress) * -Theme.popupSlide : 0
        }

        Rectangle {
            anchors.fill: parent
            visible: popup.showBackground
            color: Theme.colorBackground
            opacity: Theme.backgroundOpacity
            radius: Theme.cornerRadius
        }
    }
}
