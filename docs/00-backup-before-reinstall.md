# 00: Backup before you touch the installer

Personal note to self: do this before blindly reinstalling, to catch any last-minute file exports. Skip this section entirely if you're doing a clean install with nothing to preserve.

Do this **before** booting the Fedora Media Writer USB.

## 1. Brave bookmarks

1. Brave → Menu → Bookmarks → Bookmark Manager → ⋮ → **Export bookmarks** → save the `.html` file somewhere *off* the machine you're about to reinstall (the gdrive-sync `Projects` folder, a USB stick, wherever).
2. Keep that file until you've re-imported it post-install (Bookmark Manager → ⋮ → **Import bookmarks**).

## 2. List of manually-installed packages

Run this to check whether this documentation still matches what's actually installed on the machine. It generates a list of every user-installed package, which you can diff against this doc to see what's drifted:

```bash
dnf repoquery --userinstalled > userinstalled-packages.txt
```

## 3. List of installed Flatpaks

```bash
flatpak list --app --columns=application > userinstalled-flatpaks.txt
```

Go through both lists, update this doc with anything that's changed, and bring the config files up to date before wiping the machine.

## 4. Anything else living only on this disk

Quick gut-check before wiping: SSH keys (`~/.ssh`), GPG keys, and any local git repos that aren't pushed anywhere, including uncommitted changes. Anything not backed up in this repo or gdrive-sync is gone after the reinstall, so make sure it's packed up and this doc reflects it.

Once all of the above is off the machine, move to `docs/01-fresh-install-fedora-kde.md`.
