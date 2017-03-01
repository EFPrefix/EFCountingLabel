# EFCountingLabel

[![CI Status](http://img.shields.io/travis/EyreFree/EFCountingLabel.svg?style=flat)](https://travis-ci.org/EyreFree/EFCountingLabel)
[![Version](https://img.shields.io/cocoapods/v/EFCountingLabel.svg?style=flat)](http://cocoapods.org/pods/EFCountingLabel)
[![License](https://img.shields.io/cocoapods/l/EFCountingLabel.svg?style=flat)](http://cocoapods.org/pods/EFCountingLabel)
[![Platform](https://img.shields.io/cocoapods/p/EFCountingLabel.svg?style=flat)](http://cocoapods.org/pods/EFCountingLabel)
[![Language: Swift](https://img.shields.io/badge/language-swift-orange.svg)](https://travis-ci.org/EyreFree/EFCountingLabel)

A label which can show number change animated, in Swift.

## Overview

<img src="EFCountingLabel/Assets/example.gif" width = "50%"/>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- XCode 8.0+
- Swift 3.0+

## Installation

EFCountingLabel is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'EFCountingLabel', '~> 1.0.1'
```
## Setup

Simply initialize a `EFCountingLabel` the same way you set up a regular `UILabel`:

```swift
let myLabel = EFCountingLabel(frame: CGRect(x: 10, y: 10, width: 200, height: 40))
self.view.addSubview(myLabel)
```

You can also add it to your `xib` or `storyboard` , just make sure you set the class and module to `EFCountingLabel`.

<img src="EFCountingLabel/Assets/storyboard.png"/>

### Use

Set the format of your label. This will be filled with a single int or float (depending on how you format it) when it updates:

```swift
myLabel.format = "%d"
```

Alternatively, you can provide a `formatBlock`, which permits greater control over how the text is formatted:

```swift
myLabel.formatBlock = {
      (value) in
      return "Score: " + (formatter.string(from: NSNumber(value: Int(value))) ?? "")
}
```

There is also a `attributedFormatBlock` to use an attributed string. If the `formatBlock` is specified, it takes precedence over the `format`.

Optionally, set the mode. The default is `EFLabelCountingMethod.linear`, which will not change speed until it reaches the end. Other options are described below in the Methods section.

```swift
myLabel.method = .easeOut
```

When you want the label to start counting, just call:

```swift
myLabel.countFrom(5, to: 100)
```

You can also specify the duration. The default is 2.0 seconds.

```swift
myLabel.countFrom(1, to: 10, withDuration: 3.0)
```

Additionally, there is `animationDuration` property which you can use to override the default animation duration.

```swift
myLabel.animationDuration = 1.0
```

You can use common convinient methods for counting, such as:

```swift
myLabel.countFromCurrentValueTo(100)
myLabel.countFromZeroTo(100)
```

Behind the scenes, these convinient methods use one base method, which has the following full signature:

```swift
myLabel.countFrom(
      startValue: CGFloat,
      to: CGFloat,
      withDuration: TimeInterval
)
```

You can get current value of your label using `currentValue` method (works correctly in the process of animation too):

```swift
let currentValue = myLabel.currentValue()
```

Optionally, you can specify a `completionBlock` to perform an acton when the label has finished counting:

```swift
myLabel.completionBlock = {
      () in
      print("finish")
}
```

### Formats

When you set the `format` property, the label will look for the presence of `%(.*)d` or `%(.*)i`, and if found, will cast the value to `Int` before formatting the string. Otherwise, it will format it using a `CGFloat`.

If you're using a `CGFloat` value, it's recommended to limit the number of digits with a format string, such as `"%.1f"` for one decimal place.

Because it uses the standard `String(format: String, arguments: CVarArg...)` method, you can also include arbitrary text in your format, such as `"Points: %i"`.

### Modes
There are currently four modes of counting.

`EFLabelCountingMethod.linear`  
Counts linearly from the start to the end.  

`EFLabelCountingMethod.easeIn`  
Ease In starts out slow and speeds up counting as it gets to the end, stopping suddenly at the final value.

`EFLabelCountingMethod.easeOut`  
Ease Out starts out fast and slows down as it gets to the destination value.  

`EFLabelCountingMethod.easeInOut`  
Ease In/Out starts out slow, speeds up towards the middle, and then slows down as it approaches the destination. It is a nice, smooth curve that looks great, and is the default method.

## PS

The first version of [EFCountingLabel](https://github.com/EyreFree/EFCountingLabel/commit/5e5e12d49b84e4eff8f18df68a99b5e3223b579b) is converted from [UICountingLabel](https://github.com/dataxpress/UICountingLabel/commit/1aa3d51c1ac4d7b8aef4c5f7ea44a1b1428c7985).

## Author

EyreFree, eyrefree@eyrefree.org

## License

EFCountingLabel is available under the MIT license. See the LICENSE file for more info.

