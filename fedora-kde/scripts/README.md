# scripts/

**`gdrive-sync`** — rclone backup script, wired to a systemd user timer. Full details and a load-bearing warning in `../../docs/00-backup-before-reinstall.md` and `../../docs/02-shell-terminal-and-cli-tools.md` — read those before running this on a fresh install.

**`bluetooth-kill.txt`** — not a script (no shebang, not executable) — a copy-pasteable set of commands to fully disable Bluetooth at every level (stop the service, disable it, mask it so nothing re-enables it, and `rfkill block` the radio):

```bash
sudo systemctl stop bluetooth.service
sudo systemctl disable bluetooth.service
sudo systemctl mask bluetooth.service
sudo rfkill block bluetooth
```

To reverse: `sudo systemctl unmask bluetooth.service && sudo systemctl enable --now bluetooth.service && sudo rfkill unblock bluetooth`.
