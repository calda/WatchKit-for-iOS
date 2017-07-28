# WatchKit for iOS
WatchKit for iOS is a partial reimplementation of the WatchKit framework. It allows Apple Watch apps to run in a container view on iOS. This project was a **finalist** at HackGT 2016 in Atlanta, GA.

## Demo
Emoji Sudoku **(**[App Store](https://itunes.apple.com/us/app/emoji-sudoku/id992670313?mt=8), [GitHub](https://github.com/calda/Emoji-Sudoku)**)** is a WatchKit app I made back in 2015. WatchKit for iOS is capable of running the app's original source code with almost no modifications.

<img src="images/demo.gif" width="300px">

## Usage
### WatchKit source code
Replace instances of `import WatchKit` to `import WatchKit_iOS`. You shouldn't have to make any other changes.

### iOS
On iOS, using WatchKit for iOS is as simple as importing `WatchKit_iOS` and spinning up a new Watch view:

```swift
let watchStoryboard = WatchStoryboard(fileName: "Interface", applicationNamespace: "WatchKit_Demo")
guard let watchView = watchStoryboard?.watchView else { return }
self.watchContainer.addSubview(watchView)
```

## Supported Components
This was a 36-hour project, so it's only partial reimplementation of WatchKit. It supports `WKInterfaceController`, `WKInterfaceGroup`, `WKInterfaceLabel`, and `WKInterfaceButton`. It also supports most important storyboard components including colors, fonts, segues, IBOutlets, IBActions, and force touch Menu Items.
