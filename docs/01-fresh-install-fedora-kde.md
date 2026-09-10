# 01: Fresh install: Fedora KDE on Tachyon

The end-to-end order of operations, from bare metal to a fully configured machine. Each step links out to the doc with the actual detail; this file is just the spine, not the full content.

## 0. Backup

Do everything in `docs/00-backup-before-reinstall.md` first. Whether it's me redoing this or someone else following along, it's worth triple-checking everything before wiping to a clean slate.

## 1. Write the installer USB

Get the Fedora KDE spin ISO and write it with Fedora Media Writer:

- https://fedoraproject.org/kde/download/

Fedora Media Writer runs on Windows, macOS, and Linux. If writing the USB from another Linux box, `sudo dnf install mediawriter` (Fedora) or use the AppImage from the same page on anything else.

## 2. Boot the USB and install

Standard Fedora KDE installer (Anaconda). Points specific to this setup:

- Partitioning: btrfs (default)

## 3. First boot: get a browser to fetch install commands

Fedora KDE boots having Firefox by default (kept installed deliberately, see `docs/03`). Use it to look up the current official Brave-on-Fedora install instructions and run them in a terminal.
https://brave.com/origin/linux/
Once Brave is installed, follow `docs/03-guis-and-browser.md` → **Brave Browser** section for the full configuration (extensions, Stylus themes, vertical tabs, shortcuts, SponsorBlock, etc.). Do this early, since it's the daily-driver browser.

## 4. Open Konsole: bootstrap the essentials

Konsole is preinstalled with Plasma, so it's the bridge terminal before `foot` exists on the system.

```bash
sudo dnf install foot git
```

GitHub CLI, via the official GitHub repo (this is the documented method from cli.github.com, not a COPR):
https://github.com/cli/cli/blob/trunk/docs/install_linux.md#dnf5
```bash
sudo dnf install dnf5-plugins
sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install gh
gh auth login
```

## 5. Clone this repo

```bash
gh repo clone akshay-abraham/tachyon-dots ~/tachyon-dots
cd ~/tachyon-dots
```

(Or plain `git clone` if you'd rather not auth `gh` yet; either works.)

## 6. Foot, shell, and CLI tools

Everything here: foot config, zsh and plugins, oh-my-posh, fastfetch, neovim, keyd, the full CLI tool list, rustup/ffmpeg/RPM Fusion, snapshots, KDE Connect and firewalld, and the actual `git config`, is covered in:

→ [`docs/02-shell-terminal-and-cli-tools.md`](02-shell-terminal-and-cli-tools.md)

Once that's done, `footclient` should be your default terminal launch and the prompt/fastfetch banner should look right.

## 7. GUI apps

Removing unused Plasma apps, Brave's full config, Arduino IDE and ESP32, LibreOffice trim-down, mpv, Obsidian, Tor Browser Launcher, virtualization, Foliate, ProtonVPN, and the font set:

→ [`docs/03-guis-and-browser.md`](03-guis-and-browser.md)

## 8. KDE Plasma customization

Theme colour, cursor, fonts, animation speed, effects (blur, hidden cursor), login screen wallpaper, keybindings, hot corners, and panel/widget layout:

→ `docs/04-kde-plasma-customization.md`
