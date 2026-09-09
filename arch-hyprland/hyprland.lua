-- ~/.config/hypr/hyprland.lua
-- Minimal square Hyprland config. Single-accent green theme (#5acb76).
-- https://wiki.hypr.land/Configuring/

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "1366x768@60",
    position = "auto",
    scale    = 1,
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal      = "foot"
local terminalFast  = "footclient"
local browser       = "brave-origin"
local menu          = "rofi -show drun"
local fileManager   = "dolphin"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("hyprpolkitagent")
  hl.exec_cmd("sleep 1 && awww img /home/akshay/Pictures/wallpapers/wallpaper.png --transition-type none")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
---- LOOK AND FEEL ----
-----------------------

local border_active   = { colors = { "rgba(5acb76ee)", "rgba(2f9e58ee)" }, angle = 45 }
local border_inactive = "rgba(30363daa)"

hl.config({
    general = {
        gaps_in  = 4,
        gaps_out = 8,
        border_size = 2,

        col = {
            active_border   = border_active,
            inactive_border = border_inactive,
        },

        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding = 0,

        active_opacity   = 1.0,
        inactive_opacity = 0.95,

        shadow = {
            enabled = false,
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.15,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Curves
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("linear",       { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick",        { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Animations
hl.animation({ leaf = "global",     enabled = true,  speed = 10, bezier = "default" })
hl.animation({ leaf = "border",     enabled = true,  speed = 4,  bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",    enabled = true,  speed = 3,  bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",  enabled = true,  speed = 3.2, bezier = "easeOutQuint", style = "popin 90%" })
hl.animation({ leaf = "windowsOut", enabled = true,  speed = 1.2, bezier = "linear", style = "popin 90%" })
hl.animation({ leaf = "fadeIn",     enabled = true,  speed = 1.4, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",    enabled = true,  speed = 1.2, bezier = "almostLinear" })
hl.animation({ leaf = "fade",       enabled = true,  speed = 2.4, bezier = "quick" })
hl.animation({ leaf = "layers",     enabled = true,  speed = 3, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",  enabled = true,  speed = 3.2, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true,  speed = 1.2, bezier = "linear", style = "fade" })
hl.animation({ leaf = "workspaces", enabled = false })

hl.config({
    dwindle = {
        preserve_split = true,
        force_split    = 2,
    },

    master = {
        new_status = "master",
    },

    misc = {
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        disable_scale_notification = true,
        focus_on_activate = true,
    },

    cursor = {
        hide_on_key_press = true,
    },

    -- Mouse drag behavior
    -- A small threshold prevents accidental window movement from clicks.
    binds = {
        drag_threshold = 10,
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Apps
hl.bind(mainMod .. " + RETURN",         hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + ALT + RETURN",   hl.dsp.exec_cmd(terminalFast))
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SPACE",          hl.dsp.exec_cmd(menu))

-- File manager
-- SUPER + E = Dolphin
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))

-- Window management
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + V",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P",         hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J",         hl.dsp.layout("togglesplit"))

-- Focus movement
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move window in place
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.swap({ direction = "down" }))

-- Workspaces 1-10
for i = 1, 10 do
    local key = i % 10

    hl.bind(mainMod .. " + " .. key,
        hl.dsp.focus({ workspace = i }))

    hl.bind(mainMod .. " + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = i }))
end

-- Workspace scrolling with mouse wheel
hl.bind(mainMod .. " + mouse_down",
    hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mainMod .. " + mouse_up",
    hl.dsp.focus({ workspace = "e-1" }))

-- KDE-style mouse window management
--
-- SUPER + LEFT MOUSE BUTTON
-- Hold SUPER and drag with left mouse button to move a window.
hl.bind(
    mainMod .. " + mouse:272",
    hl.dsp.window.drag(),
    { mouse = true }
)

-- SUPER + RIGHT MOUSE BUTTON
-- Hold SUPER and drag with right mouse button to resize a window.
hl.bind(
    mainMod .. " + mouse:273",
    hl.dsp.window.resize(),
    { mouse = true }
)

-- Screenshots
hl.bind(
    "Print",
    hl.dsp.exec_cmd("grim - | tee ~/Pictures/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy")
)

hl.bind(
    mainMod .. " + SHIFT + S",
    hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy")
)

-- Refresh everything
hl.bind(
    mainMod .. " + SHIFT + R",
    hl.dsp.exec_cmd("~/.local/bin/hypr-refresh.sh")
)

-- Media/brightness
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true }
)

hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true }
)

hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true }
)

hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
    { locked = true, repeating = true }
)

hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
    { locked = true, repeating = true }
)

-- Exit session
hl.bind(
    mainMod .. " + SHIFT + E",
    hl.dsp.exec_cmd("hyprctl dispatch exit")
)

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

