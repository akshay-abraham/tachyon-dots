## Google Drive Sync

> [!CAUTION]
> **Do not enable the sync timer until your local folders have been restored from Google Drive.**
>
> The sync script uses `rclone sync` **local → remote**. This makes the remote match the local source, including deletions. On a fresh installation, an empty local directory can therefore delete its corresponding Google Drive contents.
>
> **Restore first → verify → then enable sync.**

### 1. Install rclone

```bash
sudo dnf install -y rclone
```

### 2. Configure Google Drive

Start the interactive configuration:

```bash
rclone config
```

Create a new remote named exactly:

```text
GDrive-Akshay
```

Choose **Google Drive** (`drive`) as the storage type and complete the browser-based OAuth setup.

Verify the remote:

```bash
rclone lsd GDrive-Akshay:
```

> [!IMPORTANT]
> Keep the remote name **exactly `GDrive-Akshay`**. The sync script expects this name.

Rclone stores the configuration separately from this repository. Find its location with:

```bash
rclone config file
```

### 3. Restore local data **before enabling sync**

After a fresh installation, these local directories may be empty:

```text
~/Documents/Fedora-vault/1. Fleeting Notes
~/Documents/Projects
```

**Do not run `gdrive-sync` yet.**

Use `rclone copy` to restore the required data **Google Drive → local**. For example:

```bash
rclone copy "GDrive-Akshay:<remote-path>" "$HOME/<local-path>" --progress
```

`copy` is intentionally used here: it copies files without making the destination mirror the source or deleting existing destination files.

Verify that the local folders contain the expected data before proceeding.

### 4. Install the sync script

Copy the repository script into the executable location expected by the systemd service:

```bash
mkdir -p "$HOME/bin"
cp "$HOME/tachyon-dots/fedora-kde/scripts/gdrive-sync" "$HOME/bin/gdrive-sync"
chmod +x "$HOME/bin/gdrive-sync"
```

The systemd service executes:

```text
%h/bin/gdrive-sync
```

### 5. Install the desktop entry and icon

Install the desktop launcher:

```bash
mkdir -p "$HOME/.local/share/applications"
cp "$HOME/tachyon-dots/fedora-kde/desktop-entries/google-drive-sync.desktop" \
   "$HOME/.local/share/applications/google-drive-sync.desktop"
```

Install the icon:

```bash
mkdir -p "$HOME/.local/share/icons"
curl -L \
  "https://upload.wikimedia.org/wikipedia/commons/5/5f/Google_Drive_icon_%282026%29.svg" \
  -o "$HOME/.local/share/icons/google-drive.svg"
```

### 6. Create the systemd user timer

Create the user-unit directory:

```bash
mkdir -p "$HOME/.config/systemd/user"
```

Create `gdrive-sync.service`:

```ini
[Unit]
Description=Google Drive Sync

[Service]
Type=oneshot
ExecStart=%h/bin/gdrive-sync
```

Create `gdrive-sync.timer`:

```ini
[Unit]
Description=Google Drive Sync Timer

[Timer]
OnStartupSec=15min
OnUnitInactiveSec=2h
Persistent=false

[Install]
WantedBy=default.target
```

Reload the user systemd manager:

```bash
systemctl --user daemon-reload
```

### 7. Final safety check

**Before enabling the timer, manually run the script once:**

```bash
"$HOME/bin/gdrive-sync"
```

Confirm that it is syncing **local → `GDrive-Akshay`** and that the expected files are present locally.

Only after verification, enable the timer:

```bash
systemctl --user enable --now gdrive-sync.timer
```

Verify:

```bash
systemctl --user status gdrive-sync.timer
systemctl --user list-timers --all | grep gdrive-sync
```

View sync logs with:

```bash
journalctl --user -u gdrive-sync.service
```

### Schedule

The timer is configured to:

* run **15 minutes after the user systemd manager starts**
* run again **2 hours after the sync service becomes inactive**
* **not** perform missed runs after a reboot/login (`Persistent=false`)

The service is deliberately a **user-level systemd service** because it operates on `$HOME` paths.
