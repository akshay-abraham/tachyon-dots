# 00 — Backup before you touch the installer

Do this **before** booting the Fedora Media Writer USB. Once the installer starts wiping the disk, anything not backed up is gone.

## 1. Brave bookmarks

Sync Chain has been unreliable in practice, so don't rely on it alone:

1. Brave → Menu → Bookmarks → Bookmark Manager → ⋮ → **Export bookmarks** → save the `.html` file somewhere *off* the machine you're about to reinstall (the gdrive-sync `Projects` folder, a USB stick, wherever).
2. Keep that file until you've re-imported it post-install (Bookmark Manager → ⋮ → **Import bookmarks**). This is called out again in `docs/03-guis-and-browser.md` so you don't forget the second half.

## 2. List of manually-installed packages

The goal is a list of *what you chose to install*, not the thousands of dependency packages, so you can re-request the same set on the new install.

```bash
dnf repoquery --userinstalled > userinstalled-packages.txt
```

Note: `dnf repolist --userinstalled` (repo list) is a different command from `dnf repoquery --userinstalled` (package list) — the second one is what you actually want here. Worth knowing the difference so you don't end up with a list of repo names instead of packages.

## 3. List of installed Flatpaks

```bash
flatpak list --app --columns=application > userinstalled-flatpaks.txt
```

## 4. Google Drive data — do NOT skip this

The `gdrive-sync` script (`fedora-kde/scripts/gdrive-sync`) runs `rclone sync` in the direction **local → remote**. `rclone sync` makes the destination match the source, including deletions.

On a freshly reinstalled machine, `~/Documents/Fedora-vault/1. Fleeting Notes` and `~/Documents/Projects` are **empty**. If the sync script (or its systemd timer) runs before you've restored those folders from Drive, rclone will faithfully mirror "empty" to the remote and wipe your Google Drive copy too. The `--max-delete 50` guard in the script will catch a full wipe and abort with a notification — but don't rely on a safety net you can avoid needing in the first place.

**Order of operations after reinstall:**
1. Manually download/restore the folders from Google Drive first (Drive web UI, `rclone copy` in the *remote → local* direction, or `rclone bisync` if you want two-way — anything except running the existing `sync` script cold).
2. Only *then* re-enable the systemd timer / run the sync script normally.

## 5. Anything else living only on this disk

Quick gut-check before wiping: SSH keys (`~/.ssh`), GPG keys, any local git repos not pushed anywhere, Obsidian vault (if not already inside the gdrive-synced `Projects` folder), browser extension data that doesn't sync (Bitwarden itself is fine — it's server-backed).

Once all of the above is off the machine, move to `docs/01-fresh-install-fedora-kde.md`.
