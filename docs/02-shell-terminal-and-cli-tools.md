# 02 — Shell, terminals, and CLI tools

## Terminal: foot (primary) + Konsole (fallback)

foot runs in client/server mode so new windows open instantly instead of paying Wayland/font-shaping startup cost every time:

```bash
foot --server &
```

Add that to your Plasma autostart (System Settings → Autostart → Add → Application, or drop a `.desktop` file with `Exec=foot --server` in `~/.config/autostart/`). After that, every terminal launch — including the `Meta+Return` keybinding in `docs/04` — should call `footclient`, not `foot`.

Config: symlink `fedora-kde/terminals/foot/foot.ini` → `~/.config/foot/foot.ini`. It sets JetBrains Mono Nerd Font, a 125×25 default window, a beam cursor, and box-drawing glyphs rendered from the font itself (needed for the fastfetch box borders to line up).

**Fonts note:** JetBrains Mono Nerd Font isn't in Fedora's repos as the patched Nerd Font variant. Download the Nerd Fonts release, extract into `~/.local/share/fonts/`, then `fc-cache -f`.

**Konsole** stays configured as the fallback terminal (works when foot's Wayland session is unavailable, e.g. certain recovery/TTY situations) — same font, matched size, under Konsole's own profile settings. Also used as the initial bootstrap terminal on first boot, before `foot` is installed (see `docs/01` step 4).

**kitty** config (`fedora-kde/terminals/kitty/kitty.conf`) is kept in the repo but isn't the daily driver — useful if foot's Wayland-only nature ever becomes a blocker (e.g. inside a VM without native Wayland passthrough).

## Zsh

```bash
sudo dnf install zsh
chsh -s $(which zsh)
```

Symlink `fedora-kde/shell/zshrc` → `~/.zshrc`. It expects two plugins cloned under `~/.zsh/plugins/`:

```bash
mkdir -p ~/.zsh/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/plugins/zsh-syntax-highlighting
```

Order matters: syntax-highlighting has to load *last* because it wraps every widget defined above it (autosuggestions included). If you ever add more plugins, keep syntax-highlighting at the bottom of the sourcing block.

CLI dependencies the `.zshrc` assumes are present (aliases like `zi`, `lt`, `ff`):

```bash
sudo dnf install fzf eza zoxide bat ripgrep fd-find tree wget
```

## Prompt: oh-my-posh

Not in Fedora's repos — install via oh-my-posh's own official install script (check ohmyposh.dev for the current one-liner; it changes versions often enough that pinning it here would go stale).

Theme: `fedora-kde/prompt/akshay.omp.json` → symlink to wherever your `.zshrc`'s `oh-my-posh init zsh --config` line points, typically `~/.config/oh-my-posh/akshay.omp.json`.

## fastfetch

```bash
sudo dnf install fastfetch
```

Config: `fedora-kde/fastfetch/config.jsonc` → symlink to `~/.config/fastfetch/config.jsonc`. It's hand-tuned to foot's 125-column default width (Fedora logo ≈43c + padding fills exactly the remaining 77c info block) — if you change `foot.ini`'s `initial-window-size-chars`, this layout will drift.

## Neovim

```bash
sudo dnf install neovim ripgrep
```

Then install LazyVim as the config framework, **without** its default `lazygit` dependency (drop `lazygit` from the extras/mason list if the starter template installs it by default — you're doing git from the shell/`gh` directly).

## keyd

Not in Fedora's official repos — enable the COPR you use for it, then:

```bash
sudo systemctl enable --now keyd
```

Config: `fedora-kde/keyd/default.conf` → `/etc/keyd/default.conf` (needs root; `keyd` reads system-wide, not per-user). Remaps: Caps Lock → Escape, Escape → F3, right Alt (AltGr) → Volume Up. Reload after editing:

```bash
sudo keyd reload
```

## CLI tools

Straightforward `dnf` packages:

```bash
sudo dnf install aria2 bat btop smartmontools python3-pip rclone snapper iwd tree wget
```

```bash
sudo dnf group install "Development Tools"
```

**Rust**, via `rustup` (now packaged directly in Fedora — no need for the old curl-installer):

```bash
sudo dnf install rustup
rustup-init
```

**nvm** — not packaged, install via its own official install script (github.com/nvm-sh/nvm has the current one-liner).

**iwd**: installed as an alternative Wi-Fi backend to NetworkManager's default `wpa_supplicant` — a backup, not necessarily the active one. Switch NetworkManager to use it via `/etc/NetworkManager/conf.d/wifi_backend.conf` (`[device]` / `wifi.backend=iwd`) if/when you actually want it active.

### RPM Fusion + full ffmpeg/GStreamer

Fedora ships `ffmpeg-free` — patent-encumbered codecs stripped out. RPM Fusion has the full build:

```bash
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
                  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf swap ffmpeg-free ffmpeg --allow-erasing

sudo dnf install gstreamer1-plugins-{bad-*,good-*,ugly-*,base} \
                  gstreamer1-plugin-openh264 gstreamer1-libav \
                  --exclude=gstreamer1-plugins-bad-free-devel
```

## Btrfs snapshots

```bash
sudo dnf install snapper
```

Configure via **Btrfs Assistant** (GUI) rather than hand-editing snapper configs: set up automatic snapshots on both `/` and `/home` at **3 hourly + 1 daily**, and monthly **scrub** on both. Scrub catches silent bit-rot early; on a spinning-rust-free SSD it's cheap enough to leave scheduled and forget.

## KDE Connect + firewalld

```bash
sudo systemctl enable --now firewalld
```

KDE Connect ships with Plasma. With firewalld active and set to block by default, explicitly allow the KDE Connect service so phone pairing still works:

```bash
sudo firewall-cmd --permanent --add-service=kdeconnect
sudo firewall-cmd --reload
```

Confirm nothing else got left open: `sudo firewall-cmd --list-all`.

## gdrive-sync

Script: `fedora-kde/scripts/gdrive-sync`. **Read `docs/00`'s warning before ever running this on a freshly reinstalled system** — it's a `rclone sync` (mirrors local → remote, including deletions) with a `--max-delete 50` safety guard, desktop notifications on success/failure, and a lock file so overlapping runs no-op instead of racing.

It expects an rclone remote named `GDrive-Akshay` already configured (`rclone config`) with `use_trash` **not** set to false — the script actively checks for that and refuses to run if trash is disabled, since that would make accidental deletions permanent.

Wire it up as a systemd **user** timer (not system-wide — it operates on `$HOME` paths):

```bash
mkdir -p ~/.config/systemd/user
# write gdrive-sync.service + gdrive-sync.timer here, OnBootSec=10min, OnUnitActiveSec=2h
systemctl --user enable --now gdrive-sync.timer
```

*(The actual `.service`/`.timer` unit files aren't committed to this repo yet — recreate them from the schedule above, or add them properly next time you touch this section.)*

Manual trigger: symlink/copy `fedora-kde/desktop-entries/google-drive-sync.desktop` into `~/.local/share/applications/` — gives you a launcher-menu entry that runs a sync on click, independent of the timer.

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

One thing worth actually deciding rather than defaulting into: that email is going into a **public** repo's commit history (and this doc) the moment you push. If that's intentional — fine, plenty of people do it for a real contact point. If it's not, use GitHub's `@users.noreply.github.com` address instead and set it before your first commit; changing it retroactively means rewriting history.
