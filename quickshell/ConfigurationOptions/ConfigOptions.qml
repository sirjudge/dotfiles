pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: config

    // Dev mode — true when the shell is launched for local iteration alongside
    // the real system instance (set by scripts/run_bar.sh via KORBA_SHELL_DEV).
    // Components that own a single system-wide resource (the D-Bus notification
    // daemon, the Hyprland global shortcut) skip registering it in this mode so
    // the test instance never fights the running shell for ownership.
    readonly property bool devMode: ["1", "true"].includes(Quickshell.env("KORBA_SHELL_DEV") ?? "")

    // Layout
    property int marginTop: 10
    property int marginSide: 10
    // Bar height — shared constant so the bar and notification popups agree.
    property int barHeight: 30
    // Hover-zoom factor for the expanded island: when expanded the island is
    // scaled by this (1.0 = no zoom). Purely visual (a transform), so it grows
    // over the content below rather than reserving more space.
    property real islandZoom: 1.5

    // Workspaces — full map object, indexed by screen name
    property var workspaces: ({})

    // CPU usage — displayFrom hides the pill until usage reaches this percent.
    property int cpuCritical: 90
    property int cpuWarning: 70
    property int cpuDisplayFrom: 50

    // CPU temperature — displayFrom hides the pill until temp (°C) reaches this.
    property string cpuTempSensorPath: ""
    property int cpuTempCritical: 90
    property int cpuTempWarning: 70
    property int cpuTempDisplayFrom: 70

    // GPU temperature — displayFrom hides the pill until temp (°C) reaches this.
    property bool gpuTempEnabled: true
    property string gpuTempSensorPath: ""
    property int gpuTempCritical: 90
    property int gpuTempWarning: 75
    property int gpuTempDisplayFrom: 75

    // SSD temperature — displayFrom hides the pill until temp (°C) reaches this.
    property var ssdDrives: []
    property int ssdCritical: 90
    property int ssdWarning: 75
    property int ssdDisplayFrom: 75

    // Memory — displayFrom hides the pill until usage reaches this percent.
    property int memoryCritical: 90
    property int memoryWarning: 70
    property int memoryDisplayFrom: 50

    // Weather
    property string weatherLocation: "London"

    // Session
    property string lockCommand: "hyprlock"
    property string logoutCommand: "hyprctl dispatch \"hl.dsp.exit()\""
    property int countdownDuration: 5

    // Greeter — id of the WM selected by default, and the list of WMs offered.
    // Each session: { id, label, command } where command is the argv launched
    // by greetd on successful authentication.
    // defaultUser, when non-empty, pre-fills the username and focuses password.
    property string greeterDefaultUser: ""
    property string greeterDefaultSession: "hyprland"
    // Single source of truth for the default WM list, shared by the property
    // default below and the JSON-parse fallback.
    readonly property var _defaultGreeterSessions: [
        {
            "id": "hyprland",
            "label": "Hyprland",
            "command": ["uwsm", "start", "hyprland.desktop"]
        },
        {
            "id": "niri",
            "label": "Niri",
            "command": ["uwsm", "start", "niri.desktop"]
        }
    ]
    property var greeterSessions: _defaultGreeterSessions

    // Wallpaper
    property string wallpaperFolder: "~/wallpapers/"

    // Network — seconds before a WiFi connection attempt is aborted as timed out
    property int networkConnectTimeout: 20

    // Notifications — per-urgency auto-dismiss timeouts (seconds; 0 = never)
    property int notificationTimeoutLow: 5
    property int notificationTimeoutNormal: 8
    property int notificationTimeoutCritical: 0
    property int notificationMaxVisible: 5
    property int notificationWidth: 380
    property string notificationIconTheme: "Papirus-Dark"
    property bool notificationShowCloseButton: false
    property bool notificationShowAdditionalActions: false

    // Launcher
    property int launcherMaxResults: 5

    // rbw (Bitwarden) vault picker
    property int rbwMaxResults: 8

    // Internal: file-read process
    property var _proc: Process {
        id: configProc
        command: ["sh", "-c",
            // Check local path first, then XDG_CONFIG_HOME, then ~/.config as fallback
            "f=\"./korba-shell.json\"; [ -f \"$f\" ] || f=\"${XDG_CONFIG_HOME:-$HOME/.config}/korba-shell.json\"; " +
            // Collapse newlines so SplitParser receives the JSON as a single line
            "[ -f \"$f\" ] && cat \"$f\" | tr '\\n' ' '"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                if (!data.trim())
                    return;
                try {
                    var p = JSON.parse(data);
                    // Apply each option's JSON value when present, otherwise keep
                    // the property's existing value (its declared default). This
                    // keeps every default in exactly one place — the declaration —
                    // rather than repeating each literal here as a `?? <default>`.
                    config.marginTop = p.layout?.marginTop ?? config.marginTop;
                    config.marginSide = p.layout?.marginSide ?? config.marginSide;
                    config.islandZoom = p.layout?.islandZoom ?? config.islandZoom;
                    config.workspaces = p.workspaces ?? config.workspaces;
                    config.cpuCritical = p.cpuUsage?.critical ?? config.cpuCritical;
                    config.cpuWarning = p.cpuUsage?.warning ?? config.cpuWarning;
                    config.cpuDisplayFrom = p.cpuUsage?.displayFrom ?? config.cpuDisplayFrom;
                    config.cpuTempSensorPath = p.cpuTemp?.sensorPath ?? config.cpuTempSensorPath;
                    config.cpuTempCritical = p.cpuTemp?.critical ?? config.cpuTempCritical;
                    config.cpuTempWarning = p.cpuTemp?.warning ?? config.cpuTempWarning;
                    config.cpuTempDisplayFrom = p.cpuTemp?.displayFrom ?? config.cpuTempDisplayFrom;
                    config.gpuTempEnabled = p.gpuTemp?.enabled ?? config.gpuTempEnabled;
                    config.gpuTempSensorPath = p.gpuTemp?.sensorPath ?? config.gpuTempSensorPath;
                    config.gpuTempCritical = p.gpuTemp?.critical ?? config.gpuTempCritical;
                    config.gpuTempWarning = p.gpuTemp?.warning ?? config.gpuTempWarning;
                    config.gpuTempDisplayFrom = p.gpuTemp?.displayFrom ?? config.gpuTempDisplayFrom;
                    config.ssdDrives = p.ssdTemp?.drives ?? config.ssdDrives;
                    config.ssdCritical = p.ssdTemp?.critical ?? config.ssdCritical;
                    config.ssdWarning = p.ssdTemp?.warning ?? config.ssdWarning;
                    config.ssdDisplayFrom = p.ssdTemp?.displayFrom ?? config.ssdDisplayFrom;
                    config.memoryCritical = p.memory?.critical ?? config.memoryCritical;
                    config.memoryWarning = p.memory?.warning ?? config.memoryWarning;
                    config.memoryDisplayFrom = p.memory?.displayFrom ?? config.memoryDisplayFrom;
                    config.weatherLocation = p.weather?.location ?? config.weatherLocation;
                    config.lockCommand = p.session?.lockCommand ?? config.lockCommand;
                    config.logoutCommand = p.session?.logoutCommand ?? config.logoutCommand;
                    config.countdownDuration = p.session?.countdownDuration ?? config.countdownDuration;
                    config.greeterDefaultUser = p.greeter?.defaultUser ?? config.greeterDefaultUser;
                    config.greeterDefaultSession = p.greeter?.defaultSession ?? config.greeterDefaultSession;
                    config.greeterSessions = p.greeter?.sessions ?? config._defaultGreeterSessions;
                    config.wallpaperFolder = p.wallpaper?.folder ?? config.wallpaperFolder;
                    config.networkConnectTimeout = p.network?.connectTimeout ?? config.networkConnectTimeout;
                    config.notificationTimeoutLow = p.notifications?.timeoutLow ?? config.notificationTimeoutLow;
                    config.notificationTimeoutNormal = p.notifications?.timeoutNormal ?? config.notificationTimeoutNormal;
                    config.notificationTimeoutCritical = p.notifications?.timeoutCritical ?? config.notificationTimeoutCritical;
                    config.notificationMaxVisible = p.notifications?.maxVisible ?? config.notificationMaxVisible;
                    config.notificationWidth = p.notifications?.width ?? config.notificationWidth;
                    config.notificationIconTheme = p.notifications?.iconTheme ?? config.notificationIconTheme;
                    config.notificationShowCloseButton = p.notifications?.showCloseButton ?? config.notificationShowCloseButton;
                    config.notificationShowAdditionalActions = p.notifications?.showAdditionalActions ?? config.notificationShowAdditionalActions;
                    config.launcherMaxResults = p.launcher?.maxResults ?? config.launcherMaxResults;
                    config.rbwMaxResults = p.rbw?.maxResults ?? config.rbwMaxResults;
                } catch (e) {}
            }
        }
    }

    // Poll for config changes every 2 seconds
    property var _timer: Timer {
        interval: 2000
        repeat: true
        running: true
        onTriggered: configProc.running = true
    }
}

