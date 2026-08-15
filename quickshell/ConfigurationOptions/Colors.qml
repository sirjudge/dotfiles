pragma Singleton
import QtQuick

QtObject {
    id: colors
    property color rosePineBase: "#191724"
    property color rosePineText: "#e0def4"
    property color rosePineMuted: "#6e6a86"
    property color rosePineSubtle: "#908caa"
    property color rosePineLove: "#eb6f92"
    property color rosePineGold: "#f6c177"
    property color rosePineRose: "#ebbcba"
    property color rosePinePine: "#9ccfd8"
    property color rosePineFoam: "#c4a7e7"


    // TODO: All of below is something I stole from the 
    // internet tee hee
     property color colorHighlight: "#fe8019"
    property color colorHighlightAlt: "#83a598"
    property color colorError: "#fb4934"
    property color colorWarning: "#fabd2f"
    property color colorSuccess: "#b8bb26"
    // Neutral hover tint laid over a surface (e.g. a list row) on pointer-over.
    property color colorHover: Qt.rgba(1, 1, 1, 0.05)
    // Monospaced face for the greeter text fields.
    property string fontFamilyMono: "JetBrainsMono Nerd Font"
    // Sans-serif face for prose/labels (everything except monospaced input fields).
    property string fontFamilySans: "Open Sans"
    // Icon face: Google Material Symbols, used by the Icon component (ligature
    // names). Bundled by nix/package.nix so the shell needs no system icon font.
    property string fontFamilyIcon: "Material Symbols Rounded"
    property int fontSize: 15
    // Default text weight (Font.Normal = 400): lighter than the old bold look,
    // but not as thin as Light (300).
    property int fontWeight: Font.Normal
    // Emphasis weight for `bold` text. Kept to Medium (500) rather than Bold (700)
    // so emphasised text (e.g. the clock) reads clearly without looking heavy.
    property int fontWeightBold: Font.Medium
    // Default glyph size for the Icon component. Kept larger than fontSize since
    // Google Material Symbols read poorly at text size.
    property int iconSize: 18
    // Stroke thickness for the Icon component, driving the Material Symbols `wght`
    // variable-font axis (100–700). Heavier than the 400 default for a bolder look.
    property int iconWeight: 500
    property real backgroundOpacity: 1.0
    property int cornerRadius: 8
    // Tighter radius for small inset elements (list-row highlights, chips).
    property int cornerRadiusSmall: 4

    // ---- Design tokens -------------------------------------------------------
    // Shared spacing/padding/animation constants so bar pills, tooltips and
    // popups stay visually consistent without repeating magic numbers.

    // Horizontal / vertical padding added around a pill or tooltip's content.
    property int paddingH: 16
    property int paddingV: 8
    // Inner padding for popup panels, and the gap between a popup and its anchor.
    property int popupPadding: 12
    property int popupGap: 4
    // Vertical slide distance for the popup/tooltip enter/exit transition.
    property int popupSlide: 6
    // Common inter-element spacings.
    property int spacingTiny: 4
    property int spacingSmall: 6
    property int spacingMedium: 8
    property int spacingLarge: 12
    // Opacity of hairline divider rules.
    property real dividerOpacity: 0.3
    // Popup/tooltip enter and exit animation durations (ms).
    property int animEnter: 150
    property int animExit: 110

    // Return `color` at the given alpha — shorthand for the verbose
    // Qt.rgba(c.r, c.g, c.b, a) used for hover/translucent tints.
    function withAlpha(color, alpha) {
        return Qt.rgba(color.r, color.g, color.b, alpha);
    }

    // Material Symbols ligature names below — rendered via the Icon component.

    function wifiIcon(signal) {
        if (signal <= 25)
            return "network_wifi_1_bar";
        if (signal <= 50)
            return "network_wifi_2_bar";
        if (signal <= 75)
            return "network_wifi_3_bar";
        return "signal_wifi_4_bar";
    }

    function networkIcon(isConnected, isEthernet, signal) {
        if (!isConnected)
            return "signal_wifi_off";
        if (isEthernet)
            return "lan";
        return wifiIcon(signal);
    }

    // Shown in the bar while a connection attempt is in flight (a sync/refresh
    // glyph, typically spun by the caller to read as "working").
    function networkConnectingIcon() {
        return "sync";
    }

    function freqBand(freqMhz) {
        var f = parseInt(freqMhz);
        if (f >= 5925)
            return "6 GHz";
        if (f >= 5000)
            return "5 GHz";
        return "2.4 GHz";
    }

    // Speaker glyph for the given volume level (0..1), or a muted glyph.
    // Shared by the bar Volume widget and the volume OSD.
    function volumeIcon(volume, muted) {
        if (muted)
            return "volume_off";
        if (volume <= 0.33)
            return "volume_mute";
        if (volume <= 0.66)
            return "volume_down";
        return "volume_up";
    }

    // Brightness sun glyph (fixed, independent of level).
    function brightnessIcon() {
        return "light_mode";
    }

    // Battery glyph for the given capacity (%), or a plug when on AC power.
    function batteryIcon(capacity, charging, pluggedIn) {
        if (charging || pluggedIn)
            return "power";
        if (capacity > 80)
            return "battery_android_frame_6";
        if (capacity > 64)
            return "battery_android_frame_5";
        if (capacity > 48)
            return "battery_android_frame_4";
        if (capacity > 32)
            return "battery_android_frame_3";
        if (capacity > 16)
            return "battery_android_frame_2";
        return "battery_android_frame_1";
    }

}
