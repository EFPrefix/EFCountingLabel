![](https://raw.githubusercontent.com/EFPrefix/EFCountingLabel/master/Assets/EFCountingLabel.png)

<p align="center">
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

- Xcode 16+
- Swift 6.0+

## 安装

### CocoaPods

EFCountingLabel 可以通过 [CocoaPods](https://cocoapods.org) 进行获取。只需要在你的 Podfile 中添加如下代码就能实现引入：

```ruby
pod 'EFCountingLabel'
```

然后，执行如下命令即可：

```bash
pod install
```

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) 是一个集成在 Swift 编译器中的用来进行 Swift 代码自动化发布的工具。

如果你已经建立了你的 Swift 包，将 EFCountingLabel 加入依赖是十分容易的，只需要将其添加到你的 `Package.swift` 文件的 `dependencies` 项中即可：

```swift
dependencies: [
    .package(url: "https://github.com/EFPrefix/EFCountingLabel.git", .upToNextMinor(from: "6.0.0.0"))
]
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

## 作者

EyreFree, eyrefree@eyrefree.org

## 协议

![](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/License_icon-mit-88x31-2.svg/128px-License_icon-mit-88x31-2.svg.png)

EFCountingLabel 基于 MIT 协议进行分发和使用，更多信息参见 [协议文件](LICENSE)。
