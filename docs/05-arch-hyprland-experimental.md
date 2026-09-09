# 05 — Arch + Hyprland (experimental, VM)

## Current state: mostly a placeholder

Straight answer: the `arch-hyprland/` folder in this repo is empty except for a stub `README.md`. The original plan referenced an `arch/` folder with configs already in it, but no such folder or files were actually part of what got uploaded to build this repo — only the Fedora KDE side had real config files attached. So rather than fabricate Hyprland/rofi configs that don't exist yet, this doc is an honest placeholder plus a checklist of what still needs to be pulled off the actual machine (or VM) and committed.

This runs as a minimal Arch install inside a VM (see `docs/03` → Virtualization) — not a second bare-metal boot target, based on the setup described.

## What's known to exist but isn't committed yet

- `hyprland.conf` — main Hyprland compositor config.
- `rofi` config — app launcher, referenced but no file attached.
- An Arch-specific `.zshrc` — the `fedora-kde/shell/zshrc` in this repo is explicitly the Fedora edition; a second, Arch-side zshrc was mentioned but never provided.
- Waybar or whatever status bar is actually in use with Hyprland (not mentioned explicitly, but a bare Hyprland setup needs *something* for a bar/tray — worth confirming and documenting rather than assuming).

## Suggested structure once those files exist

```
arch-hyprland/
├── hypr/hyprland.conf
├── rofi/config.rasi
├── zsh/zshrc
└── waybar/ (if applicable)
```

## To do

1. Pull the actual config files off the VM (`hyprland.conf`, rofi config, Arch zshrc, any bar config) and drop them into the structure above.
2. Replace this doc's checklist with the same level of detail as `docs/02`–`04`: what packages, what `pacman`/AUR helper commands, what the minimal-setup philosophy actually is for this VM (is it meant to stay minimal permanently, or is it a testbed for eventually replacing Fedora KDE on the main machine?). That question matters — it changes whether this doc should read as "toy setup, don't overinvest" or "staging ground, document as carefully as the main system."
3. Until then, treat this section of the repo as **not yet trustworthy** for a reinstall — unlike `docs/01`–`04`, which reflect a real, currently-running configuration.
