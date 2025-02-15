![](https://raw.githubusercontent.com/EFPrefix/EFCountingLabel/master/Assets/EFCountingLabel.png)

<p align="center">
    <a href="https://travis-ci.org/EFPrefix/EFCountingLabel">
    	<img src="https://img.shields.io/travis/EFPrefix/EFCountingLabel.svg">
    </a>
    <a href="https://swiftpackageindex.com/EFPrefix/EFCountingLabel">
        <img src="https://img.shields.io/badge/SPM-ready-orange.svg">
    </a>
    <a href="https://cocoapods.org/pods/EFCountingLabel">
    	<img src="https://img.shields.io/cocoapods/v/EFCountingLabel.svg?style=flat">
    </a>
    <a href="https://cocoapods.org/pods/EFCountingLabel">
    	<img src="https://img.shields.io/cocoapods/p/EFCountingLabel.svg?style=flat">
    </a>
    <a href="https://github.com/apple/swift">
    	<img src="https://img.shields.io/badge/language-swift-orange.svg">
    </a>
    <a href="https://raw.githubusercontent.com/EFPrefix/EFCountingLabel/master/LICENSE">
    	<img src="https://img.shields.io/cocoapods/l/EFCountingLabel.svg?style=flat">
    </a>
</p>

A label which can show number change animated in Swift, inspired by [UICountingLabel](https://github.com/dataxpress/UICountingLabel).

> [中文介绍](https://github.com/EFPrefix/EFCountingLabel/blob/master/README_CN.md)

## Overview

<img src="https://raw.githubusercontent.com/EFPrefix/EFCountingLabel/master/Assets/example.gif" width = "35%"/>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Xcode 16+
- Swift 6.0+

## Installation

### CocoaPods

EFCountingLabel is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'EFCountingLabel'
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the Swift compiler.

Once you have your Swift package set up, adding EFCountingLabel as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/EFPrefix/EFCountingLabel.git", .upToNextMinor(from: "6.0.0.0"))
]
```

## Setup

Simply initialize a `EFCountingLabel` the same way you set up a regular `UILabel`:

```swift
let myLabel = EFCountingLabel(frame: CGRect(x: 10, y: 10, width: 200, height: 40))
self.view.addSubview(myLabel)
```

You can also add it to your `xib` or `storyboard` , just make sure you set the class and module to `EFCountingLabel`.

<img src="https://raw.githubusercontent.com/EFPrefix/EFCountingLabel/master/Assets/storyboard.png"/>

### Use

Set the format of your label. This will be filled with string (depending on how you format it) when it updates, you can provide a `formatBlock`, which permits greate control over how the text is formatted. If not provided, the default format will be `"%d"`:

```swift
myLabel.setUpdateBlock { value, label in
    label.text = String(format: "%.2f%%", value)
}
```

Optionally, set the timing function. The default is `EFTimingFunction.linear`, which will not change speed until it reaches the end. Other options are described below in the Methods section.

```swift
myLabel.counter.timingFunction = EFTimingFunction.easeOut(easingRate: 3)
```

When you want the label to start counting, just call:

```swift
myLabel.countFrom(5, to: 100)
```

You can also specify the duration. The default is 2.0 seconds.

```swift
myLabel.countFrom(1, to: 10, withDuration: 3.0)
```

You can use common convinient methods for counting, such as:

```swift
myLabel.countFromCurrentValueTo(100)
myLabel.countFromZeroTo(100)
```

Behind the scenes, these convinient methods use one base method, which has the following full signature:

```swift
myLabel.countFrom(startValue: CGFloat, to: CGFloat, withDuration: TimeInterval)
```

You can get current value of your label using `currentValue` method (works correctly in the process of animation too):

```swift
let currentValue: CGFloat = myLabel.counter.currentValue
```

Optionally, you can specify a `completionBlock` to perform an acton when the label has finished counting:

```swift
myLabel.completionBlock = { () in
    print("finish")
}
```

### Modes

There are currently four modes of counting.

- EFTimingFunction.linear: Counts linearly from the start to the end;
- EFTimingFunction.easeIn: Ease In starts out slow and speeds up counting as it gets to the end, stopping suddenly at the final value;
- EFTimingFunction.easeOut: Ease Out starts out fast and slows down as it gets to the destination value;
- EFTimingFunction.easeInOut: Ease In/Out starts out slow, speeds up towards the middle, and then slows down as it approaches the destination. It is a nice, smooth curve that looks great, and is the default method;
- EFTimingFunction.easeInBounce;
- EFTimingFunction.easeOutBounce.

## Author

EyreFree, eyrefree@eyrefree.org

## License

![](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/License_icon-mit-88x31-2.svg/128px-License_icon-mit-88x31-2.svg.png)

EFCountingLabel is available under the MIT license. See the LICENSE file for more info.
