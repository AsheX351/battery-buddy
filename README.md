# Battery Buddy 🔋

Cute cartoon character battery status indicator for macOS Touch Bar.

## Features

- 🎨 **Animated Cartoon Character**: Cute little buddy that changes appearance based on battery level
- 📊 **Touch Bar Display**: Shows on the right side of Touch Bar
- 🔋 **Battery Indicator**: Visual battery bar next to the character
- 🎯 **Auto-Refresh**: Updates every 5 minutes
- 🚀 **Auto-Start**: Launches automatically on login
- 🌙 **Dark Mode**: Native dark appearance for macOS 15.5+

## Requirements

- macOS 15.5 or later
- Touch Bar hardware (MacBook Pro 2016+)

## Installation

### One-Command Install

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/AsheX351/battery-buddy/main/install.sh)
```

### Manual Build & Install

```bash
# Clone repository
git clone https://github.com/AsheX351/battery-buddy.git
cd battery-buddy

# Build
swift build -c release

# Create app bundle
bash build.sh

# Install
cp -r battery-buddy.app /Applications/

# Launch
open /Applications/battery-buddy.app
```

## How to Use

1. Launch the app (or auto-starts on login)
2. Look at your Touch Bar - the cute character appears on the right side
3. Character and battery bar change color based on battery level:
   - 🟢 **75-100%**: Bright green (full energy!)
   - 🟡 **50-74%**: Yellow-green (good)
   - 🟠 **25-49%**: Orange (warning)
   - 🔴 **0-24%**: Red (critical)

## Battery Levels

| Level | Character | Color | Status |
|-------|-----------|-------|--------|
| 75-100% | Happy & Bouncy | Green | Fully Charged |
| 50-74% | Content | Yellow-Green | Good |
| 25-49% | Cautious | Orange | Low |
| 0-24% | Worried | Red | Critical |

## Auto-Start Setup

During installation, you'll be asked if you want auto-start enabled.

```bash
# To enable later:
launchctl load ~/Library/LaunchAgents/com.battery-buddy.plist

# To disable:
launchctl unload ~/Library/LaunchAgents/com.battery-buddy.plist

# Check status:
launchctl list | grep battery-buddy
```

## Uninstall

```bash
# Remove app
rm -rf /Applications/battery-buddy.app

# Remove auto-start
launchctl unload ~/Library/LaunchAgents/com.battery-buddy.plist 2>/dev/null
rm ~/Library/LaunchAgents/com.battery-buddy.plist 2>/dev/null
```

## File Structure

```
├── Package.swift              # Swift Package configuration
├── Sources/
│   ├── main.swift            # Entry point
│   ├── AppDelegate.swift      # App lifecycle & battery monitoring
│   ├── MenuBarController.swift # Menu bar icon
│   ├── TouchBarController.swift # Touch Bar integration
│   └── BatteryCharacterView.swift # Cartoon character animation
├── build.sh                  # Create .app bundle
├── install.sh                # One-command installer
└── README.md
```

## Technical Details

- **Language**: Swift 5.9
- **Framework**: AppKit (native macOS)
- **Battery Monitoring**: IOKit power source API
- **Touch Bar**: NSTouchBar API
- **Update Frequency**: Every 5 minutes
- **Binary Size**: ~2MB

## License

MIT

## Support

For issues or feature requests, visit: https://github.com/AsheX351/battery-buddy/issues
