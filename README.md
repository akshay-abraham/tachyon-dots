# tachyon-dots

Personal dotfiles and system-setup reference for **Tachyon** — a Dell Vostro 3446 dual-booting **Fedora KDE** (daily driver) and an experimental **Arch + Hyprland** VM.

This is not a one-command bootstrap script. It's configs + a written record of *why* things are set up this way, so a reinstall is a checklist, not a guessing game.

## Structure

```
tachyon-dots/
├── docs/                       — full write-ups, read these first
│   ├── 00-backup-before-reinstall.md
│   ├── 01-fresh-install-fedora-kde.md
│   ├── 02-shell-terminal-and-cli-tools.md
│   ├── 03-guis-and-browser.md
│   ├── 04-kde-plasma-customization.md
│   └── 05-arch-hyprland-experimental.md
├── fedora-kde/
│   ├── shell/zshrc              — main shell config
│   ├── terminals/foot/foot.ini
│   ├── terminals/kitty/kitty.conf
│   ├── prompt/akshay.omp.json   — oh-my-posh theme
│   ├── fastfetch/config.jsonc
│   ├── keyd/default.conf        — caps→esc, esc→F3, AltGr→volume up
│   ├── scripts/gdrive-sync      — rclone backup script (read the warning in docs/00 before running)
│   ├── scripts/bluetooth-kill.txt
│   ├── desktop-entries/         — google-drive-sync.desktop, arduino.desktop
│   ├── browser/brave/stylus/    — Economist, DuckDuckGo, Wikipedia userstyles
│   └── grub-theme/catppuccin-mocha-grub-theme/
├── arch-hyprland/               — stub, see docs/05
└── windows/windhawk-taskbar-styler/win_taskbar_mode.cpp
```

## Machine

| | |
|---|---|
| Host | Dell Vostro 3446 ("Tachyon") |
| CPU / GPU | Intel i3-4005U (iGPU) + NVIDIA 820M |
| RAM | 4 GB |
| Display | 14" 1366×768 |
| Boot 1 | Fedora 44 KDE Plasma 6.6.5, Wayland, kernel 7.0.8 |
| Boot 2 | Arch + i3 (terminal-first) / Hyprland VM (experimental) |

4 GB RAM is the constraint that shapes most of the choices in here — Memory Saver on max in Brave, foot as primary terminal with Konsole only as fallback, snapshot cadence tuned to not thrash a low-power CPU. Worth remembering before copying any of this onto different hardware.

## Using this repo

```bash
git clone https://github.com/<your-username>/tachyon-dots.git
cd tachyon-dots
```

Then follow `docs/01-fresh-install-fedora-kde.md` in order — it links out to the other docs at the point in the install where each becomes relevant. Config files are meant to be symlinked, not copied, e.g.:

```bash
ln -sf ~/tachyon-dots/fedora-kde/shell/zshrc ~/.zshrc
ln -sf ~/tachyon-dots/fedora-kde/terminals/foot ~/.config/foot
ln -sf ~/tachyon-dots/fedora-kde/terminals/kitty ~/.config/kitty
```

so future edits in the repo are live and `git status` actually shows drift.

## Honest gaps (as of this writing)

- No `install.sh`. Everything here is manual, documented steps — that's a deliberate v1 choice, not a recommendation to leave it that way forever. If you reinstall more than once a year, script it.
- `arch-hyprland/` has no configs committed yet, just a placeholder — see `docs/05`.
- `zshrc` here is the Fedora version only; the Arch-side `.zshrc` doesn't exist in this repo yet.
- Package names in the docs are what's correct on Fedora 44 at time of writing. Fedora repos drift — `dnf search <name>` before trusting a command blindly on a future version.

## License

MIT — see `LICENSE`. Configs are yours to fork; the third-party userstyles under `fedora-kde/browser/brave/stylus/` retain whatever license their original authors used (Economist/Wikipedia forks credit tsuni.dev in the file headers — keep that attribution if you redistribute).
