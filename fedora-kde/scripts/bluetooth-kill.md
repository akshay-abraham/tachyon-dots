commands to fully disable Bluetooth at every level (stop the service, disable it, mask it so nothing re-enables it, and `rfkill block` the radio):

```bash
sudo systemctl stop bluetooth.service
sudo systemctl disable bluetooth.service
sudo systemctl mask bluetooth.service
sudo rfkill block bluetooth
```

To reverse: `sudo systemctl unmask bluetooth.service && sudo systemctl enable --now bluetooth.service && sudo rfkill unblock bluetooth`.
