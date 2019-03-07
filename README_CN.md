![](https://raw.githubusercontent.com/EFPrefix/EFCountingLabel/master/Assets/EFCountingLabel.png)

<p align="center">
    <a href="https://travis-ci.org/EFPrefix/EFCountingLabel">
    	<img src="https://img.shields.io/travis/EFPrefix/EFCountingLabel.svg">
    </a>
    <a href="http://cocoapods.org/pods/EFCountingLabel">
    	<img src="https://img.shields.io/cocoapods/v/EFCountingLabel.svg?style=flat">
    </a>
    <a href="http://cocoapods.org/pods/EFCountingLabel">
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

为 UILabel 添加计数动画支持，Swift 实现。

> [English Introduction](README.md)

## 预览

<img src="https://raw.githubusercontent.com/EFPrefix/EFCountingLabel/master/Assets/example.gif" width = "50%"/>

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

## 安装

EFCountingLabel 可以通过 [CocoaPods](http://cocoapods.org) 进行获取。只需要在你的 Podfile 中添加如下代码就能实现引入：

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

设置标签格式. 设置标签格式后，标签会在更新数值的时候以你设置的方式填充，默认是显示 float 类型的数值，也可以设置成显示 int 类型的数值，比如下面的代码：

```swift
myLabel.format = "%d"
```

另外，你也可以使用 `formatBlock`，这个可以对显示的文本格式进行更加高度的自定义：

```swift
myLabel.formatBlock = {
      (value) in
      return "Score: " + (formatter.string(from: NSNumber(value: Int(value))) ?? "")
}
```

除此之外还有一个 `attributedFormatBlock` 用于设置属性字符串的格式，用法和上面的 block 类似。如果指定了以上两个 `formatBlock` 中的任意一个，它将会覆盖掉 `format`属性，因为 block 的优先级更高。

可选项，设置动画样式，默认的动画样式是 `EFLabelCountingMethod.linear`，这个样式是匀速显示动画。以下将介绍其他动画样式及用法：

```swift
myLabel.method = .easeOut
```

需要计数时只需要使用以下方法即可：

```swift
myLabel.countFrom(5, to: 100)
```

可以指定动画的时长，默认时长是 2.0 秒。

```swift
myLabel.countFrom(1, to: 10, withDuration: 3.0)
```

另外，也可以使用 `animationDuration` 属性去设置动画时长。

```swift
myLabel.animationDuration = 1.0
```

可以使用便利方法计数，例如：

```swift
myLabel.countFromCurrentValueTo(100)
myLabel.countFromZeroTo(100)
```

本质上，这些便利方法都是基于一个总方法封装的，以下就是这个方法完整的声明：

```swift
myLabel.countFrom(
      startValue: CGFloat,
      to: CGFloat,
      withDuration: TimeInterval
)
```

可以使用 `currentValue` 方法获得当前数据（即使在动画过程中也可以正常获得）：

```swift
let currentValue = myLabel.currentValue()
```

可选项，可以使用 `completionBlock` 获得动画结束的事件：

```swift
myLabel.completionBlock = {
      () in
      print("finish")
}
```

### 格式

当设置 `format` 属性后，标签会检测是否有 `%(.*)d` 或者 `%(.*)i` 格式，如果能找到，就会将内容以 `Int` 类型展示。否则，将会使用默认的 `CGFloat` 类型展示。

假如你需要以 `CGFloat` 类型展示，最好设置小数点位数限制，例如使用 `@"%.1f"` 来限制只显示一位小数。

因为使用了标准的 `String(format: String, arguments: CVarArg...)` 方法，你可以按照自己的意愿自定义格式，例如：`@"Points: %i"`。

### 模式

当前有多种动画模式：

- EFLabelCountingMethod.linear：匀速计数动画，是默认采用的动画样式；
- EFLabelCountingMethod.easeIn：开始比较缓慢,快结束时加速,结束时突然停止；
- EFLabelCountingMethod.easeOut：开始速度很快,快结束时变得缓慢；
- EFLabelCountingMethod.easeInOut：开始时比较缓慢，中间加速，快结束时减速。动画速度是一个平滑的曲线。
- ...

## 备注

[EFCountingLabel](https://github.com/EFPrefix/EFCountingLabel/commit/5e5e12d49b84e4eff8f18df68a99b5e3223b579b) 基于 [UICountingLabel](https://github.com/dataxpress/UICountingLabel/commit/1aa3d51c1ac4d7b8aef4c5f7ea44a1b1428c7985) 进行开发，在此对 UICountingLabel 原开发者及其所做的工作表示感谢。

## 作者

EyreFree, eyrefree@eyrefree.org

## 协议

![](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/License_icon-mit-88x31-2.svg/128px-License_icon-mit-88x31-2.svg.png)

EFCountingLabel 基于 MIT 协议进行分发和使用，更多信息参见 [协议文件](LICENSE)。
