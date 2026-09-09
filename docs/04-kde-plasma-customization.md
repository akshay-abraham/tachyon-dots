# 04 — KDE Plasma customization

Everything here is set through System Settings GUI panels rather than hand-edited config files, so this doc is the reference — there's nothing to symlink for most of it.

## Theme

- System Settings → Colors → accent colour: **`#5acb76`**.
- Cursor theme: **Bibata-Modern-Ice**. Not in Fedora's repos — download the release, extract into `/usr/share/icons/` (system-wide) so it's selectable for both the desktop session and the SDDM login screen.
- Fonts → Monospace: **JetBrains Mono Nerd Font** (same font as `foot`/Konsole, for visual consistency between terminal and any UI element that falls back to monospace).
- Workspace animation speed: **+1 step faster than default**. On a low-power iGPU this is a real tradeoff — faster animations feel snappier but cost a touch more compositing overhead. If Plasma ever feels sluggish after a Fedora upgrade, this is one of the first settings worth reverting to test.

## Desktop effects

- **Hide cursor** (auto-hides the mouse pointer when idle/typing).
- **Blur** enabled (behind panels, Overview, etc.).

Both are compositor effects — on the 820M's limited power budget, if you ever notice frame drops during window animations, blur is the first one to disable, not the last.

## Login screen (SDDM) & lock screen

- Wallpaper: rotating daily Bing wallpapers, scaled and cropped to fit (rather than centered/tiled — avoids letterboxing on the 1366×768 panel).
- SDDM settings → enable **"Apply Plasma settings"** (or equivalent — the checkbox that mirrors your desktop theme/cursor/accent choices onto the login screen itself), so the login screen doesn't look like a different theme entirely from the desktop session.

## Keybindings

Custom shortcuts, set via System Settings → Shortcuts → Custom Shortcuts (for the app-launching ones) and Window Management (for tiling/window actions):

| Shortcut | Action |
|---|---|
| `Meta + Return` | Launch `footclient` |
| `Meta + Shift + Return` | Launch Brave |
| `Meta + Up` | Maximize window |
| `Meta + Down` | Minimize window |
| `Meta + Shift + Q` | Close window |
| `Meta + Page Down` | Tile window to bottom half of screen |
| `Meta + Page Up` | Tile window to top half of screen |
| `Meta + Ctrl + Z` | Toggle trackpad on/off |
| `Meta + B` | Exempt current window/process from battery power-saving |

That last one (`Meta+B`) is worth double-checking against whatever it's actually bound to when you rebuild this — "unassign from battery" as a description is vague enough that it could mean either a custom script toggling a specific app's power-profile exemption, or something tied to `powerprofilesctl`. Pin down the exact command before you rely on muscle memory for it on a new install.

## Hot corners

System Settings → Desktop Effects → Screen Edges:

| Corner | Action |
|---|---|
| Top-left | Overview |
| Bottom-left | Application launcher |
| Bottom-right | Show desktop |

## Panel configuration

- Remove the "Peek at Desktop" widget from the panel (redundant with the bottom-right hot corner above).
- Date/time widget format: `ddd d` (e.g. "Mon 9").
- Add widgets, grouped near the system tray:
  - **Memory usage** widget.
  - A third-party **thermal monitor** widget, configured to surface CPU temperature specifically — useful on the i3-4005U given how easily it thermal-throttles under sustained load.
  - **Note maker** widget, configured with a transparent background.
- System tray: configure to show only essentials by default (collapse the rest behind the expand arrow).
- Task manager: icons-only mode, middle-click on a task to close its window.
- Application launcher icon: set to `start-here-kde-plasma` (under "All icons" in the icon picker, not the default Fedora-branded one). Enable "switch categories on hover" in the sidebar and set applications to display as **name only** (no description line) — meaningfully more entries visible per screen on a 768px-tall panel.
