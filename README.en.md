<p align="center">
  <img src="https://raw.githubusercontent.com/cho-hm/floatme/main/FloatMe/Resources/AppIcon.png" width="128" height="128" alt="FloatMe">
</p>

<h1 align="center">FloatMe</h1>

<p align="center">
  <strong>A Floating App Switcher for macOS</strong><br>
  Pin your favorite apps on screen and switch with a single click.
</p>

<p align="center">
  <a href="README.md">🇰🇷 한국어</a> · 🇺🇸 English (current)
</p>

<p align="center">
  <img src="https://img.shields.io/badge/macOS-15%2B-blue?style=flat-square" alt="macOS 15+">
  <img src="https://img.shields.io/badge/Swift-6.0%2B-F05138?style=flat-square&logo=swift&logoColor=white" alt="Swift 6.0+">
  <img src="https://img.shields.io/badge/License-Proprietary-red?style=flat-square" alt="Proprietary">
  <img src="https://img.shields.io/github/v/release/cho-hm/floatme?style=flat-square&label=Latest" alt="Latest Release">
</p>

---

## What is FloatMe?

When you have many apps open, Cmd+Tab becomes a chore. The Dock sits at the bottom, sometimes hidden or far from your cursor.

**FloatMe** lets you pin your frequently used apps as small floating icons anywhere on your screen. One click brings all windows of that app to the front.

## Features

**Floating Bar**
- Pin running apps in horizontal or vertical layout
- Click to switch — brings all windows of the app to front
- Blue dot indicator for the currently focused app
- Auto-shrink icons when too many are pinned (min 20px, max 96px)

**Edit Mode**
- Right-click → "Edit Mode"
- Icons wiggle like iOS, showing ✕ (remove) and + (add) buttons
- Drag to reorder icons

**Smart Movement**
- Drag the handle to position anywhere on screen
- Auto-snap to screen edges (hold Shift to bypass)
- Free movement across multiple monitors
- Lock/unlock position

**Persistent Pinning**
- Pinned apps survive app restarts — they reappear when relaunched
- Only explicitly removed apps leave the list
- Up to 5 apps can be pinned

**Customization**
- Background style: Blur (default) / Dark / Transparent
- Adjustable background opacity (50–100%) and icon size (20–96px)
- Hide active app on re-click (optional)
- Auto-hide in fullscreen (default ON)
- Launch at login
- Hide Dock icon

**Menu Bar**
- Quick access from the menu bar icon: Show Floating Bar (⌘⇧F), Add App (⌘⇧A), Preferences (⌘,)

**Auto Updates**
- Sparkle-based in-app updates
- Right-click → "Check for Updates"

## Install

### Download DMG (Recommended)

[**Download Latest Release**](https://github.com/cho-hm/floatme/releases/latest)

1. Download the DMG file
2. Drag FloatMe.app to Applications
3. First launch: Right-click → "Open"

### Build from Source

```bash
git clone https://github.com/cho-hm/floatme.git
cd floatme
bash scripts/package.sh
open dist/FloatMe.app
```

## Usage

| Action | How |
|--------|-----|
| Switch app | Click icon |
| Add app | + button in edit mode, menu bar "Add App..." (⌘⇧A) |
| Remove app | ✕ in edit mode, right-click "Remove from Floating", Option+Click |
| Edit mode | Right-click → "Edit Mode" |
| Move bar | Drag the handle (hold Shift to bypass snap) |
| Show/Hide bar | Menu bar → "Show Floating Bar" (⌘⇧F) |
| Toggle orientation | Right-click or menu bar → "Toggle Orientation" |
| Lock position | Right-click → "Lock / Unlock Position" |
| Preferences | Right-click or menu bar → "Preferences..." (⌘,) |
| Check for updates | Right-click → "Check for Updates..." |

## Requirements

- macOS 15 (Sequoia) or later
- Apple Silicon or Intel Mac

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Language | Swift 6.0+ (Xcode 16+) |
| UI | SwiftUI + AppKit Hybrid |
| Floating Window | NSPanel (nonactivatingPanel) |
| App Detection | NSWorkspace Notification |
| Background | NSVisualEffectView |
| Storage | UserDefaults + Codable |
| Auto Update | Sparkle |
| Distribution | DMG |

## License

[Proprietary](LICENSE) — Source code is viewable, but modification, redistribution, and commercial use are prohibited. Personal non-commercial use only.
