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
    <a href="https://shang.qq.com/wpa/qunwpa?idkey=d0f732585dcb0c6f2eb26bc9e0327f6305d18260eeba89ed26a201b520c572c0">
        <img src="https://img.shields.io/badge/Q群-769966374-32befc.svg?logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAQCAMAAAARSr4IAAAA4VBMVEUAAAAAAAAAAAD3rwgAAAAAAADpICBuTQNUDAwAAAAAAAAAAAAAAADnICAAAAAAAACbFRUAAAD5rgkfFgEAAADHGxu1GBhGOyQ6LhMPCgAAAAB0UQRbDAziHh7hHh5HRUEAAAAPAgIQCwEQEBAdBAQgICAvIQIvLy8+LAJAQEBJCgpWRBpbW1tfX19gYGBqZVptTARvb299VwSAgICEhISHh4ePhnGbbAWgoKCseAawsLC7gwbAwMDExMTFrKzLjgfoHx/powfqpAjvZGTw8PDxcnLxenrzj4/5rgj5x8f///9y6ONcAAAAIHRSTlMAECAgMEBQVlhggZGhobHBwdHR3eHh4+fp7/Hx9/f5+3tefS0AAACkSURBVHjaNc1FAsJAEAXRDj64BAv2IbgEd2s0gfsfiJkAtXurIpkWMQBd0K8O3KZfhWEeW9YB8LnUYY2Gi6WJqJIHwKo7GAMpRT/aV0d2BhRD/Xp7tt9OGs2yYoy5mpUxc0BOc/yvkiQSwJPZtu3XCdAoDtjMb5k8C9KN1utx+zFChsD97bYzRII0Ss2/7IUliILFjZKV8ZLM61xK+V6tsHbSRB+BYB6Vhuib7wAAAABJRU5ErkJggg==">
    </a>
</p>

为 UILabel 添加计数动画支持，Swift 实现，受 [UICountingLabel](https://github.com/dataxpress/UICountingLabel) 启发。

> [English Introduction](https://github.com/EFPrefix/EFCountingLabel/blob/master/README.md)

## 预览

<img src="https://raw.githubusercontent.com/EFPrefix/EFCountingLabel/master/Assets/example.gif" width = "35%"/>

## 示例

1. 利用 `git clone` 命令下载本仓库；
2. 利用 cd 命令切换到 Example 目录下，执行 `pod install` 命令；
3. 随后打开 `EFCountingLabel.xcworkspace` 编译即可。

或执行以下命令：

```bash
git clone git@github.com:EFPrefix/EFCountingLabel.git; cd EFCountingLabel/Example; pod install; open EFCountingLabel.xcworkspace
```

## 环境

| 版本 | 需求                                |
|:--------|:-------------------------------------|
| 1.x     | Xcode 8.0+<br>Swift 3.0+<br>iOS 8.0+ |
| 4.x     | Xcode 9.0+<br>Swift 4.0+<br>iOS 8.0+ |
| 5.x     | Xcode 10.0+<br>Swift 5.0+<br>iOS 8.0+ |

## 安装

EFCountingLabel 可以通过 [CocoaPods](https://cocoapods.org) 进行获取。只需要在你的 Podfile 中添加如下代码就能实现引入：

```ruby
pod 'EFCountingLabel'
```

然后，执行如下命令即可：

```bash
pod install
```

## 设置

初始化 `EFCountingLabel` 的方式和普通的 `UILabel` 是一样的：

```swift
let myLabel = EFCountingLabel(frame: CGRect(x: 10, y: 10, width: 200, height: 40))
self.view.addSubview(myLabel)
```

你也可以用在 `xib` 或 `storyboard` 中，前提是你在模块引用中引入了 `EFCountingLabel`。

<img src="https://raw.githubusercontent.com/EFPrefix/EFCountingLabel/master/Assets/storyboard.png"/>

### 使用

设置标签格式. 设置标签格式后，标签会在更新数值的时候以你设置的方式填充，你可以使用 `formatBlock`，这个可以对显示的文本格式进行高度的自定义。如果不提供，默认的样式是 `"%d"`：

```swift
myLabel.setUpdateBlock { value, label in
    label.text = String(format: "%.2f%%", value)
}
```

可选项，设置动画样式，默认的动画样式是 `EFTimingFunction.linear`，这个样式是匀速显示动画。以下将介绍其他动画样式及用法：

```swift
myLabel.counter.timingFunction = EFTimingFunction.easeOut(easingRate: 3)
```

需要计数时只需要使用以下方法即可：

```swift
myLabel.countFrom(5, to: 100)
```

可以指定动画的时长，默认时长是 2.0 秒。

```swift
myLabel.countFrom(1, to: 10, withDuration: 3.0)
```

可以使用便利方法计数，例如：

```swift
myLabel.countFromCurrentValueTo(100)
myLabel.countFromZeroTo(100)
```

本质上，这些便利方法都是基于一个总方法封装的，以下就是这个方法完整的声明：

```swift
myLabel.countFrom(startValue: CGFloat, to: CGFloat, withDuration: TimeInterval)
```

可以使用 `currentValue` 方法获得当前数据（即使在动画过程中也可以正常获得）：

```swift
let currentValue: CGFloat = myLabel.counter.currentValue
```

可选项，可以使用 `completionBlock` 获得动画结束的事件：

```swift
myLabel.completionBlock = { () in
    print("finish")
}
```

### 模式

当前有多种动画模式：

- EFTimingFunction.linear：匀速计数动画，是默认采用的动画样式；
- EFTimingFunction.easeIn：开始比较缓慢,快结束时加速,结束时突然停止；
- EFTimingFunction.easeOut：开始速度很快,快结束时变得缓慢；
- EFTimingFunction.easeInOut：开始时比较缓慢，中间加速，快结束时减速。动画速度是一个平滑的曲线。
- EFTimingFunction.easeInBounce；
- EFTimingFunction.easeOutBounce。

## 使用 EFCountingLabel 的应用

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

## 作者

EyreFree, eyrefree@eyrefree.org

## 协议

![](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/License_icon-mit-88x31-2.svg/128px-License_icon-mit-88x31-2.svg.png)

EFCountingLabel 基于 MIT 协议进行分发和使用，更多信息参见 [协议文件](LICENSE)。
