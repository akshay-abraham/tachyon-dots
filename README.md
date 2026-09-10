# tachyon-dots

Personal dotfiles and system-setup reference for **Tachyon**.

This is a personal repo, built so every minor tweak I've made stays reproducible for myself. It isn't a one-command bootstrap script: it's configs plus a written record of *why* things are set up this way, so a reinstall becomes a checklist instead of a guessing game.

You can jump straight to the dotfiles, especially [`zshrc`](fedora-kde/shell/zshrc) (years of accumulated tweaks) or the [oh-my-posh config](fedora-kde/prompt/akshay.omp.json), which I'm fairly convinced is one of the best-looking oh-my-posh themes out there.

## Using this repo

```bash
git clone https://github.com/akshay-abraham/tachyon-dots.git
cd tachyon-dots
```

Then follow `docs/01-fresh-install-fedora-kde.md` in order. It links out to the other docs at the point in the install where each becomes relevant. Config files are meant to be symlinked, not copied. For example:

```bash
ln -sf ~/tachyon-dots/fedora-kde/shell/zshrc ~/.zshrc
ln -sf ~/tachyon-dots/fedora-kde/terminals/foot ~/.config/foot
ln -sf ~/tachyon-dots/fedora-kde/terminals/kitty ~/.config/kitty
```

## License

MIT: see `LICENSE`. Configs are free to fork.

The Wikipedia userstyle ([`wiki.user.css`](fedora-kde/browser/brave/stylus/wiki.user.css)) is a derivative work. It was originally created by [Tsuni](https://userstyles.world/style/25529) (a warm "sand" color scheme with Atkinson Hyperlegible typography and a floating-card Wikipedia layout) and has been substantially rewritten, redesigned, and extended by Akshay Abraham, including full dark-mode support and a CSS-only collapsible References section. Original attribution is retained per the source license.
