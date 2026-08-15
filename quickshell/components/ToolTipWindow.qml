pragma ComponentBehavior: Bound
import "../components"

// A hover tooltip dropping from a bar widget. Bind `shouldShow` to the hover
// state and declare the tooltip body as children; the anchoring, animation and
// background come from AnchoredPopup.
AnchoredPopup {
    property bool shouldShow: false
    isOpen: shouldShow
}
