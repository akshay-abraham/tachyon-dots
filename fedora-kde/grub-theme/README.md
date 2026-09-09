# catppuccin-mocha-grub-theme

Catppuccin Mocha GRUB theme with the Dell logo swapped in (`logo.png`), based on the catppuccin mocha GRUB2 themes.

## Install

```bash
sudo mkdir -p /boot/grub2/themes/catppuccin-mocha
sudo cp -r catppuccin-mocha-grub-theme/* /boot/grub2/themes/catppuccin-mocha/
```

Edit `/etc/default/grub`, add or update:

```
GRUB_THEME="/boot/grub2/themes/catppuccin-mocha/theme.txt"
```

Regenerate the GRUB config:

```bash
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```
