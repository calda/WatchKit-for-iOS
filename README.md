# WatchKit for iOS
WatchKit for iOS is a UIKit-based reimplementation of the WatchKit framework. It lets you run Apple Watch apps on iOS. This project was a **finalist** at HackGT 2016 in Atlanta, GA.

## Demo
**[Emoji Sudoku](https://github.com/calda/Emoji-Sudoku)** is a WatchKit app I made back in 2015. WatchKit for iOS is capable of running the app's original source code with almost no modifications. The current App Store version of Emoji Sudoku uses this framework.

<img src="images/demo.gif" width="300px">

## Usage
### Carthage

You can add WatchKit for iOS to your Xcode project by using Carthage. Just add `github "calda/WatchKit-for-iOS"` to your `cartfile`.

### WatchKit source code
Replace instances of `import WatchKit` to `import WatchKit_iOS`. You shouldn't have to make any other changes.

### iOS
On iOS, using WatchKit for iOS is as simple as importing `WatchKit_iOS` and spinning up a new `WatchContainerViewController`:

```swift
let watchViewController = WatchContainerViewController.create(
    withInterfaceFileNamed: "Watch Interface", // the name of the .xml file that matches the WatchKit .storyboard
    inNamespace: "Emoji Sudoku") // the name of the iOS app target that includes the imported WatchKit source code
        
watchViewController.modalTransitionStyle = .crossDissolve
watchViewController.modalPresentationStyle = .overFullScreen
self.present(watchViewController, animated: true, completion: nil)
```

## Supported Components
This was a 36-hour project, so it's only partial reimplementation of WatchKit. It supports `WKInterfaceController`, `WKInterfaceGroup`, `WKInterfaceLabel`, and `WKInterfaceButton`. It also supports most important storyboard components including colors, fonts, segues, IBOutlets, IBActions, and force touch Menu Items.
