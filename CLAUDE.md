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

# Validate CocoaPods spec
pod spec lint LSExtensions.podspec
```

## Architecture

LSExtensions is a pure Swift extension library distributed via both CocoaPods and Swift Package Manager.

**Minimum targets:** iOS 13+ (SPM), iOS 9+ (CocoaPods)
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

The `LSExtensions/Extensions/Objc/` directory is excluded from the SPM target (CocoaPods only).
`LSExtensions/Readme/` contains markdown docs for select extensions — excluded from both build targets.

Tests are under `Tests/LSExtensionsTests/` (SPM) and `LSExtensionsTests/` (legacy Xcode target).

## Releasing

1. Bump `s.version` in `LSExtensions.podspec`
2. Commit with message `bump: release a.b.c`
3. Create branch named `a.b.c` (version number only)
4. After merge, tag the commit with the version number so CocoaPods can resolve it via `{ :git => ..., :tag => "a.b.c" }`
