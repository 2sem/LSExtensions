# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Build
swift build

# Run all tests
swift test

# Run a single test
swift test --filter LSExtensionsTests/testMethodName
```

## Architecture

LSExtensions is a pure Swift extension library distributed via Swift Package Manager.

**Minimum target:** iOS 15+
**No external dependencies.**

### Source Layout

All extensions live under `LSExtensions/Extensions/`, organized by framework:

| Directory | Frameworks covered |
|---|---|
| `DataTypes/` | String, Int, Double, Float, Bool, Date, Array, Collection, URL, etc. |
| `UIKit/` | UIView, UIViewController, UITableView, UIButton, UIImage, UIColor, UIFont, etc. |
| `AVFoundation/` | AVPlayer, AVPlayerItem, AVAudioSession, CMTime |
| `Foundation/` | URLRequest, Decodable |
| `Device/` | UIDevice, Notification, UIInterfaceOrientationMask |
| `Contacts/` | CNContact, CNContactStore |
| `CoreData/` | NSFetchedResultsController |
| `CoreImage/` | CIFilter |
| `FileSystem/` | FileManager |
| `MediaPlayer/` | MPRemoteCommandCenter, MPVolumeView |
| `Thread/` | DispatchQueue |
| `WebKit/` | WKWebView |

`LSExtensions/Readme/` contains markdown docs for select extensions — excluded from the build target.

Tests are under `Tests/LSExtensionsTests/`.

## Releasing

1. Bump the version in `Package.swift` (if needed) and create branch `a.b.c`
2. Commit with message `bump: release a.b.c`
3. After merge, tag the commit with the version number for SPM resolution
