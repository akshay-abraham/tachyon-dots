# 02: Shell, terminals, and CLI tools

## Terminal: foot (primary) + Konsole (fallback)

## Foot Server/Client

```bash
sudo dnf install foot
# Enable the user socket:
systemctl --user enable --now foot-server.socket
```

The socket listens on `/run/user/$UID/foot.sock`. When `footclient` is launched, systemd starts the `foot-server` service automatically; the server then remains running to serve subsequent clients.

### KDE Plasma

1. Open **System Settings → Apps & Windows → Default Applications → Terminal Emulator**.
2. Set the default terminal to **Foot Client (`footclient`)**.
3. Add a keyboard shortcut:
   * **Meta + Enter** → `footclient`
4. Add **Foot Client** to the taskbar and pin it to **Favorites**.
> **Important:** Use `footclient` for the desktop integration and shortcuts, not `foot`. The server is managed automatically through `foot-server.socket`.

Config: symlink `fedora-kde/terminals/foot/foot.ini` → `~/.config/foot/foot.ini`. It sets JetBrains Mono Nerd Font, a 125×25 default window, a beam cursor, and box-drawing glyphs rendered from the font itself (needed for the fastfetch box borders to line up).

**Fonts note:** the patched Nerd Font variant of JetBrains Mono isn't in Fedora's repos. Download it from the official [Nerd Fonts releases](https://www.nerdfonts.com/font-downloads), extract into `~/.local/share/fonts/`, then run `fc-cache -f`.

**Konsole** stays configured as the fallback terminal: same font, matched size, set under Konsole's own profile settings.

**kitty** config (`fedora-kde/terminals/kitty/kitty.conf`) is kept in the repo but isn't the daily driver. I like kitty too, but foot has every feature I actually use and is far lighter, so foot wins.
## Zsh

```bash
# cli essentials
sudo dnf install fzf eza zoxide bat ripgrep fd-find tree wget
sudo dnf install zsh
chsh -s $(which zsh)
```

```bash
# Symlink Zsh config + Oh My Posh prompt
ln -sfn ~/tachyon-dots/fedora-kde/shell/zshrc ~/.zshrc
ln -sfn ~/tachyon-dots/fedora-kde/prompt/akshay.omp.json ~/akshay.omp.json
```
```bash
# Zsh plugins — shallow clone, replace stale copies
mkdir -p ~/.zsh/plugins
rm -rf ~/.zsh/plugins/zsh-autosuggestions ~/.zsh/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
    ~/.zsh/plugins/zsh-autosuggestions &&
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting \
    ~/.zsh/plugins/zsh-syntax-highlighting
# Reload Zsh
exec zsh
```

```bash
## Prompt: oh-my-posh
curl -s https://ohmyposh.dev/install.sh | bash -s
```
## fastfetch

```bash
# Install Fastfetch
sudo dnf install -y fastfetch

# Link configuration
mkdir -p "$HOME/.config/fastfetch" &&
ln -sfn "$HOME/tachyon-dots/fedora-kde/fastfetch/config.jsonc" \
    "$HOME/.config/fastfetch/config.jsonc"
```
It's hand-tuned to foot's 125-column default width (Fedora logo ≈43c + padding fills exactly the remaining 77c info block). If you change `foot.ini`'s `initial-window-size-chars`, this layout will drift.

## Neovim / LazyVim

```bash
# Neovim + native dependencies
sudo dnf install -y neovim tree-sitter-cli gcc curl ripgrep fd fzf

# Clone LazyVim starter
git clone https://github.com/LazyVim/starter ~/.config/nvim

# Remove starter's Git history
rm -rf ~/.config/nvim/.git

# Start Neovim
nvim
```

> **Note:** `lazygit` is intentionally not installed.

After installation, run:
```vim
:LazyHealth
```

This loads the plugins and checks that the setup is working correctly.

## keyd

```bash
# Enable keyd COPR + install
sudo dnf copr enable -y alternateved/keyd
sudo dnf install -y keyd

# Copy configuration
sudo cp "$HOME/tachyon-dots/fedora-kde/keyd/default.conf" /etc/keyd/default.conf

# Enable + start
sudo systemctl enable --now keyd

# Apply configuration
sudo keyd reload
```
## AI tools

`gh copilot` and `opencode` are the two actually installed and used day to day. Everything else below is optional; install whichever you prefer instead.

Run `gh copilot` (bundled with the GitHub CLI installed back in `docs/01` step 4).

Install opencode:

```bash
curl -fsSL https://opencode.ai/install | bash
```

Optional, install Codex CLI:

```bash
curl -fsSL https://chatgpt.com/codex/install.sh | sh
```

Or install any other preferred agent, like Claude Code:

```bash
curl -fsSL https://claude.ai/install.sh | bash
```
## CLI tools

Straightforward `dnf` packages:

```bash
sudo dnf install aria2 bat btop smartmontools python3-pip rclone snapper iwd tree wget
```

```bash
# Fedora 44 / DNF5
sudo dnf group install development-tools
# C/C++ build toolchain + development headers
sudo dnf install -y gcc gcc-c++ make glibc-devel kernel-headers
```

```bash
sudo dnf install rustup
rustup-init
```

**nvm**: not packaged. Install it via its own official install script (https://nodejs.org/en/download).

**iwd**: installed as an alternative Wi-Fi backend to NetworkManager's default `wpa_supplicant`. It's a backup, not necessarily the active one. Switch NetworkManager to use it via `/etc/NetworkManager/conf.d/wifi_backend.conf` (`[device]` / `wifi.backend=iwd`) if and when you actually want it active.

### RPM Fusion + full ffmpeg/GStreamer

Fedora ships `ffmpeg-free`, with patent-encumbered codecs stripped out. RPM Fusion has the full build:
```bash
# RPM Fusion repositories
sudo dnf install -y \
    https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Full FFmpeg
sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing

# Full multimedia / GStreamer stack
sudo dnf update -y @multimedia \
    --setopt="install_weak_deps=False" \
    --exclude=PackageKit-gstreamer-plugin
```
## Btrfs snapshots

```bash
sudo dnf install btrfs-assistant snapper
```

Configure via **Btrfs Assistant** (GUI) rather than hand-editing snapper configs: set up automatic snapshots on both `/` and `/home` at **3 hourly + 1 daily**, and monthly **scrub** on both. Scrub catches silent bit-rot early; on a spinning-rust-free SSD it's cheap enough to leave scheduled and forget.

## KDE Connect + firewalld
```bash
# Enable firewall
sudo systemctl enable --now firewalld

# Default zone: block unsolicited incoming traffic
sudo firewall-cmd --set-default-zone=drop
# Allow KDE Connect
sudo firewall-cmd --permanent --zone=drop --add-service=kdeconnect
# Apply changes
sudo firewall-cmd --reload
# Verify
sudo firewall-cmd --zone=drop --list-all
```
## btop
```bash
sudo dnf install btop
```
## GitHub CLI + Copilot + git config

`gh` install is in `docs/01` step 4 (it's needed early, to clone this repo). Git identity and credential setup:

```bash
git config --global user.name "Akshay Abraham"
git config --global user.email "akshaykroobenabraham@gmail.com"
git config --global core.editor "zed --wait"
git config --global init.defaultBranch main
git config --global credential."https://github.com".helper "!/usr/bin/gh auth git-credential"
git config --global credential."https://gist.github.com".helper "!/usr/bin/gh auth git-credential"
```
## Gdrive sync

Full setup: [`docs/05-google-drive-sync.md`](05-google-drive-sync.md).
