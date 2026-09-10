# 03: Browser and GUI apps

## Brave Browser

Install via Brave's own official Linux instructions, https://brave.com/origin/linux/ (found live through Firefox on first boot; see `docs/01`).

### Extensions
- **Bitwarden** login and lock settings and autofill enabled.
- **Stylus**: three custom userstyles live in `fedora-kde/browser/brave/stylus/`:
  - `the-economist-native-dark.user.css`
  - `ducky.user.css`
  - `wiki.user.css`: a fork of tsuni.dev's Wikipedia dark-mode work, with additional bug fixes and features layered on top. Keep the attribution in the file header if you ever redistribute it.

  Plus a YouTube "clean" theme and a YouTube cinema-mode theme from stylus userstyles.

  Stylus performance settings: **Instant Inject Mode** on, **style cache duration** set to ~7 (days). Noticeably cuts style-flash-of-unstyled-content on page load.

- **SponsorBlock**: configured to auto-skip most segment categories and show highlighted segments on the seek bar. Anything not auto-skipped is still visible to skip manually.
- **AdList / SponsorBlock combo** tuned specifically for YouTube on top of the base uBO lists.

### Brave settings
- **Brave Shields**: beyond the default lists, add [uBO lists](https://github.com/uBlockOrigin/uAssets/tree/master/filters), [EasyList and EasyPrivacy](https://easylist.to/), and the URLhaus malicious URL blocklist: https://gitlab.com/malware-filter/urlhaus-filter#malicious-url-blocklist.
- Vertical tabs enabled.
- Custom keyboard shortcuts (Settings → Extensions/Shortcuts or `brave://settings/shortcuts`… actually under Brave's Keyboard Shortcuts settings page):
  - `Ctrl+Alt+S`: toggle maximize for the vertical tabs sidebar
  - `Ctrl+Alt+C`: copy current URL
- Custom search engines added: a DuckDuckGo-based custom search shortcut, plus separate keyword shortcuts for searching YouTube and a GPT/ChatGPT engine directly from the address bar.
- Compact UI density.
- Show memory usage on tab hover (`brave://flags` → memory usage in hovercards).
- Sidebar pinned to the right, reveal-on-hover, with YouTube Music and other frequently used bookmarks pinned to it.
- Downloads: don't prompt for a save location every time. Pick a default download folder and leave it.
- Don't close the browser when the last tab closes.
- Memory Saver: set to **maximum** aggressiveness (this matters a lot more on 4 GB RAM than it would on a normal machine).
- Set up Brave's Sync Chain with phone.
- On startup: open a fresh new tab, not "continue where you left off."

### Bookmarks
Handled day-to-day via Brave's Sync Chain, but it isn't fully reliable. **Before any reinstall, export bookmarks manually** (see `docs/00`), and **remember to re-import them** here once Brave is freshly configured post-install (Bookmark Manager → ⋮ → **Import bookmarks**).
## Removing unused Plasma apps

Fedora KDE ships a full Plasma application suite by default. Keep everything **except** Plasma's bundled games, the Contacts app (KAddressBook), and the mail client (KMail/Kontact); remove those, plus anything else installed by default that goes unused.

```bash
dnf list installed | grep -i kde
```

gives you the actual installed package names to target. They vary slightly by Fedora version, which is exactly why this doc doesn't hardcode them. Once you've identified them:

```bash
sudo dnf remove <package-name>
```

## Zed

Install Zed: https://zed.dev/docs/linux#zed-on-linux

Configure Zed to use JetBrains Mono Nerd Font at a size matching `foot.ini`, for visual consistency with the terminal. In its general settings, set it to only open the launchpad or relaunch, not the previous project.

Configure Zed to use zsh as the default shell for its integrated terminal.

Install AI assistant plugins for GitHub Copilot and others. Install the JetBrains Dark theme and the Material Icon pack. Set GitHub Copilot as the default AI agent.

Zed keyboard shortcut: `Ctrl+Shift+~`: maximize terminal pane.
## Konsole

Preinstalled with Plasma. Set its profile font to JetBrains Mono Nerd Font at a size matching `foot.ini`, so it's a visually consistent fallback terminal rather than a jarring one.

## Kdenlive + Inkscape

```bash
sudo dnf install kdenlive inkscape
```

## Arduino IDE + ESP32

Not packaged for Fedora, so it runs as an AppImage:

1. Download the [Arduino IDE logo SVG](https://upload.wikimedia.org/wikipedia/commons/7/73/Arduino_IDE_logo.svg) and the AppImage itself, place both under `~/Applications/`.
2. Use `fedora-kde/desktop-entries/arduino.desktop` as the launcher. It expects the AppImage and icon at that path, so either match it exactly or edit the `Exec=`/`Icon=` lines to match wherever you actually put them. Drop the file into `~/.local/share/applications/`.
3. Inside the Arduino IDE itself: Preferences → Additional Board Manager URLs → add the official ESP32 boards URL (get the current one from within the Arduino IDE itself).
4. Boards Manager → search `esp32` → install.

## Firefox

Set the default browser to Brave once it's installed. Firefox stays as the backup: it's what Fedora KDE boots to by default anyway (used on first boot specifically to fetch the Brave install command, per `docs/01`). No further customization; it's the "if Brave breaks" option, not a daily driver.

## LibreOffice

Fedora KDE installs the full suite. Trim to just Writer and Calc:

```bash
dnf list installed 'libreoffice-*'
```

then remove the components you don't use (Impress, Draw, Base, Math are the usual suspects; exact package names per the command above, since they shift slightly between Fedora versions):

```bash
sudo dnf remove libreoffice-impress libreoffice-draw libreoffice-base libreoffice-math
```

In whichever LibreOffice apps remain: Tools → Options → View → enable the **tabbed** (ribbon-style) toolbar UI.

## mpv

```bash
sudo dnf install mpv yt-dlp
```

Theme: the "modern-z" mpv skin isn't packaged. Download it and drop it under `~/.config/mpv/scripts/` or `~/.config/mpv/` per that theme's own install instructions: https://github.com/Samillion/ModernZ

## Obsidian

Not in Fedora's official repos; install via Flatpak. Once installed:
https://obsidian.md/download
- Enable the **Excalidraw** and **Kanban** community plugins.
- Set the note font to **Atkinson Hyperlegible Next** (part of the font set below) for readability during long writing sessions.

## Tor Browser Launcher

```bash
sudo dnf install torbrowser-launcher
```

## Virtualization

```bash
sudo dnf install @virtualization
```

Check BIOS/UEFI *first*: Intel VT-x needs to be enabled, or none of this does anything. After install:

```bash
sudo systemctl enable --now libvirtd
sudo usermod -aG libvirt $(whoami)
```

(log out/in for the group change to apply).

## Foliate (ebook reader)

```bash
sudo dnf install foliate
```

## ProtonVPN

Not in Fedora's default repos. Proton publishes its own official `.rpm` repo with setup instructions on their site; add that and install the GUI client from it: https://protonvpn.com/support/official-linux-vpn-fedora

## Custom app icons

Sourced from the gdrive-synced folder at `~/Documents/Projects/Pictures/`, meaning they arrive via the `gdrive-sync` script (`docs/02`), not this repo directly. Apply them per app via the KDE menu editor.

## Fonts

```
Atkinson Hyperlegible Next   Bookerly Display   Inter 4.1        Microsoft Aptos Fonts   Source Sans 3
Bookerly                     EB Garamond        JetBrainsMono    SegoeUI-VF
```
Drop `.ttf`/`.otf` files under `~/.local/share/fonts/`, then:

```bash
fc-cache -f
```
to make them available system-wide without a reboot.
