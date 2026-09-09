# 01 — Fresh install: Fedora KDE on Tachyon

The end-to-end order of operations, from bare metal to a fully configured machine. Each step links to the doc with the actual detail — this file is the spine, not the full content.

## 0. Backup

Do everything in `docs/00-backup-before-reinstall.md` first. Not optional.

## 1. Write the installer USB

Get the Fedora KDE spin ISO and write it with Fedora Media Writer:

- https://fedoraproject.org/kde/download/

Fedora Media Writer runs on Windows/macOS/Linux — if writing the USB from another Linux box, `sudo dnf install mediawriter` (Fedora) or use the AppImage from the same page on anything else.

## 2. Boot the USB and install

Standard Fedora KDE installer (Anaconda). Points specific to this setup:

- Partitioning: if you want Btrfs snapshots (see `docs/02`), keep the default Btrfs layout Fedora KDE ships with — don't switch to ext4.
- Set hostname to `tachyon` (or whatever — just be consistent, the gdrive-sync script and desktop entries assume a fixed `$HOME`).
- Create the user account now; you'll `dnf install` and configure everything else after first boot.

## 3. First boot — get a browser to fetch install commands

Fedora KDE boots to Firefox by default (kept installed deliberately, see `docs/03`). Use it to look up the current official Brave-on-Fedora install instructions and run them in a terminal — Brave publishes its own repo/installer and it changes occasionally, so pulling it live beats a stale command baked into a doc.

Once Brave is installed, follow `docs/03-guis-and-browser.md` → **Brave Browser** section for the full configuration (extensions, Stylus themes, vertical tabs, shortcuts, SponsorBlock, etc.) — do this early since it's the daily-driver browser.

## 4. Open Konsole — bootstrap the essentials

Konsole is preinstalled with Plasma, so it's the bridge terminal before `foot` exists on the system.

```bash
sudo dnf install foot git
```

GitHub CLI, via the official GitHub repo (this is the documented method from cli.github.com, not a COPR):

```bash
sudo dnf install 'dnf-command(config-manager)'
sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install gh
gh auth login
gh extension install github/gh-copilot
```

## 5. Clone this repo

```bash
gh repo clone <your-username>/tachyon-dots ~/tachyon-dots
cd ~/tachyon-dots
```

(Or plain `git clone` if you'd rather not auth `gh` yet — either works, `gh` is just convenient since it's already installed.)

## 6. Foot, shell, and CLI tools

Everything here — foot config, zsh + plugins, oh-my-posh, fastfetch, neovim, keyd, the full CLI tool list, rustup/ffmpeg/RPM Fusion, snapshots, KDE Connect + firewalld, and the actual `git config` — is in:

→ `docs/02-shell-terminal-and-cli-tools.md`

Once that's done, `footclient` should be your default terminal launch and the prompt/fastfetch banner should look right.

## 7. GUI apps

Removing unused Plasma apps, Brave's full config, Arduino IDE + ESP32, LibreOffice trim-down, mpv, Obsidian, Tor Browser Launcher, virtualization, Foliate, ProtonVPN, and the font set:

→ `docs/03-guis-and-browser.md`

## 8. KDE Plasma customization

Theme colour, cursor, fonts, animation speed, effects (blur, hidden cursor), login screen wallpaper, keybindings, hot corners, and panel/widget layout:

→ `docs/04-kde-plasma-customization.md`

## 9. Restore Google Drive data

Only after everything above — see the warning in `docs/00`. Restore `Fleeting Notes` and `Projects` from Drive manually, re-import Brave bookmarks, re-request the package/flatpak lists you backed up, *then* let the gdrive-sync systemd timer take over.

## 10. Sanity check

- `footclient` opens instantly (means `foot --server` is running — check the systemd user service/autostart, not covered separately since it's a one-line addition to your session startup).
- `btrfs-assistant` shows the snapshot schedule active on both `/` and `/home`.
- `kdeconnect-cli --list-devices` sees your phone, and `sudo firewall-cmd --list-all` shows only KDE Connect's ports open beyond the defaults.
- Panel, theme, and keybindings match `docs/04`.

That's a working Tachyon.
