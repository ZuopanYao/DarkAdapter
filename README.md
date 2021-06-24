# DarkAdapter
iOS 暗黑模式(Dark Mode) 适配库

DarkAdapter to make adjust dark mode on iOS.

[![Platform](https://img.shields.io/cocoapods/p/DarkAdapter.svg?style=flat)](https://github.com/ZuopanYao/DarkAdapter)
[![Cocoapods Compatible](https://img.shields.io/cocoapods/v/DarkAdapter.svg)](https://cocoapods.org/pods/DarkAdapter)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Requirements / 使用条件

- iOS 11.0+ 
- Xcode 12.0+
- Swift 5.0+

## Installation / 安装

### CocoaPods

```
pod 'DarkAdapter'
```

### Manually / 手动安装

If you prefer not to use either of the aforementioned dependency managers, you can integrate DarkAdapter into your project manually.

如果您不喜欢以上管理依赖库的方式，则可以手动将 DarkAdapter 集成到项目中。


## Usage / 使用

### The general adjust dark mode

```swift
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let isDark = UITraitCollection.current.userInterfaceStyle == .dark
        if isDark {
            view.backgroundColor = .red
        } else {
            view.backgroundColor = .blue
        }
    }
}

```

### Make use of DarkAdapter

```swift
import DarkAdapter

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.da.backgroundColor = (.blue, .red)
        // OR
        // view.da.backgroundColor = (light: .blue, dark: .red)
    }
}

```

### Support Attribute

|UIView|
|:-----|
|backgroundColor|
|shadowColor|
|borderColor|
|tintColor|
|alpha|
|shadowOpacity|

**Additional**

|UIButton|
|:-----|
|image|
|backgroundImage|
|title|
|titleColor|

|UIImageView|
|:-----|
|image|
|highlightedImage|


|UILabel|
|:-----|
|textColor|

|UITextView|
|:-----|
|textColor|

|UITextField|
|:-----|
|textColor|

## License / 许可证

DarkAdapter is released under the MIT license. See LICENSE for details.

DarkAdapter 是在 MIT 许可下发布的，有关详情请查看该许可证。