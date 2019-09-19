![](https://raw.githubusercontent.com/EFPrefix/EFCountingLabel/master/Assets/EFCountingLabel.png)

<p align="center">
    <a href="https://travis-ci.org/EFPrefix/EFCountingLabel">
    	<img src="https://img.shields.io/travis/EFPrefix/EFCountingLabel.svg">
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
    <a href="https://twitter.com/EyreFree777">
    	<img src="https://img.shields.io/badge/twitter-@EyreFree777-blue.svg?style=flat">
    </a>
    <a href="https://www.weibo.com/eyrefree777">
    	<img src="https://img.shields.io/badge/weibo-@EyreFree-red.svg?style=flat">
    </a>
    <img src="https://img.shields.io/badge/made%20with-%3C3-orange.svg">
</p>

A label which can show number change animated in Swift, inspired by [UICountingLabel](https://github.com/dataxpress/UICountingLabel).

> [中文介绍](https://github.com/EFPrefix/EFCountingLabel/blob/master/README_CN.md)

## Overview

<img src="https://raw.githubusercontent.com/EFPrefix/EFCountingLabel/master/Assets/example.gif" width = "35%"/>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

| Version | Needs                                |
|:--------|:-------------------------------------|
| 1.x     | Xcode 8.0+<br>Swift 3.0+<br>iOS 8.0+ |
| 4.x     | Xcode 9.0+<br>Swift 4.0+<br>iOS 8.0+ |
| 5.x     | Xcode 10.0+<br>Swift 5.0+<br>iOS 8.0+ |

## Installation

EFCountingLabel is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'EFCountingLabel'
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

## Apps using EFCountingLabel

<table>
  <tr>
    <td>
      <a href='https://www.appsight.io/app/toss-%ED%86%A0%EC%8A%A4' title='토스'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/263/485/media/small.png?1530945069'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/%EC%87%BC%ED%95%91%EC%9D%84-%EB%9A%9D%EB%94%B1-%ED%8B%B0%EB%AA%AC' title='티몬 - 오늘은 또 어떤 딜?'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/286/380/media/small.png?1534301992'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/%EB%B1%85%ED%81%AC%EC%83%90%EB%9F%AC%EB%93%9C' title='뱅크샐러드'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/282/332/media/small.png?1533591669'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/climendo-basic' title='Climendo Basic'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/000/304/533/media/small.png?1481531280'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/flights-by-studentuniverse' title='Flights by StudentUniverse'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/323/006/media/small.png?1546882044'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/get-help-app' title='Get Help App'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/142/904/media/small.png?1522690431'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/golden-full-adan-%D8%A7%D9%84%D9%85%D8%A4%D8%B0%D9%86-%D8%A7%D9%84%D8%B0%D9%87%D8%A8%D9%8A' title='Golden Full Adan|المؤذن الذهبي'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/112/855/media/small.png?1519607778'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/hoteltonight' title='HotelTonight - Great Deals on Last Minut'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/000/273/459/media/small.png?1479256441'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/how-much-fun-question-game' title='How Much? Fun Question Game!'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/000/733/135/media/small.png?1500948444'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/liven' title='Liven - Eat, Pay &amp; Earn'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/328/804/media/small.png?1548126411'>
      </a>
    </td>
  </tr>
  <tr>
    <td>
      <a href='https://www.appsight.io/app/nokia-mobile-tribe' title='Nokia mobile Tribe'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/365/336/media/small.png?1554343173'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/pixel-plex' title='Pixel Plex'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/154/867/media/small.png?1523055553'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/press-app-sports' title='Press Sports'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/342/478/media/small.png?1551806101'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/pro-football-quiz' title='Pro Football Quiz'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/352/466/media/small.png?1552411434'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/quigle' title='Quigle - Feud for Google'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/164/030/media/small.png?1523391205'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/santander' title='Santander'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/352/254/media/small.png?1552404876'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/shapeapp-just-shape-it' title='ShapeApp — Just shape it!'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/103/691/media/small.png?1519090064'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/skl-united' title='SKL United'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/174/614/media/small.png?1523680530'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/sports-fan-quiz' title='Sports Fan Quiz'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/366/043/media/small.png?1554388634'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/subway-app' title='SUBWAY®'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/266/262/media/small.png?1531077961'>
      </a>
    </td>
  </tr>
  <tr>
    <td>
      <a href='https://www.appsight.io/app/swiftshift' title='SwiftShift'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/308/688/media/small.png?1537899006'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/that-s-right-gameshow' title='That's Right Live Gameshow'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/288/204/media/small.png?1534618310'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/808425' title='Turbo: Scores-Income &amp; Credit'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/127/464/media/small.png?1521057782'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/unmute' title='Unmute - Live Talk Shows'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/000/517/671/media/small.png?1490936474'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/%D9%83%D8%A7%D8%B4%D9%81-%D8%B3%D8%A7%D9%87%D8%B1' title='كاشف ساهر'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/304/894/media/small.png?1537424006'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/%E5%8D%81%E7%82%B9%E8%AF%BB%E4%B9%A6-%E6%9C%89%E5%A3%B0%E5%90%AC%E4%B9%A6%E9%98%85%E8%AF%BB%E5%9B%BE%E4%B9%A6%E9%A6%86' title='十点读书 - 有声听书精品课程'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/334/858/media/small.png?1550728341'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/%E8%87%BA%E7%81%A3%E8%B6%85%E5%A8%81%E7%9A%84' title='臺灣超威的'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/251/232/media/small.png?1530205300'>
      </a>
    </td>
    <td>
      <a href='https://www.appsight.io/app/piano-rush' title='Piano Rush - Piano Games'>
        <img src='https://d3ixtyf8ei2pcx.cloudfront.net/icons/001/372/226/media/small.png?1555017024'>
      </a>
    </td>
  </tr>
</table>

## Author

EyreFree, eyrefree@eyrefree.org

## License

![](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/License_icon-mit-88x31-2.svg/128px-License_icon-mit-88x31-2.svg.png)

EFCountingLabel is available under the MIT license. See the LICENSE file for more info.
