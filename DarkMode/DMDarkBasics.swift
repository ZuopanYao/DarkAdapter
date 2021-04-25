//
//  DMDarkBasics.swift
//  DarkMode
//
//  Created by Harvey on 2021/4/22.
//

import UIKit

/// Defualt is "_dark"
public var darkImageSuffix: String = "_dark"

public struct DMDarkBasics<Base> {
    
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public protocol DMDarkBasicsCompatible {
    
    associatedtype CompatibleType
    var dm: DMDarkBasics<CompatibleType> { get set }
}

public extension DMDarkBasicsCompatible {
    
    var dm: DMDarkBasics<Self> {
        get { DMDarkBasics(self) }
        set { }
    }
}

extension NSObject: DMDarkBasicsCompatible { }

public func DMAdjustValue<Base>(_ light: Base?, _ dark: Base?) -> Base? {
    return  isDark ? dark : light
}

// MARK: - Only internal access
let attributeStore = DMAttributeStore.shared

var isDark: Bool {
    guard #available(iOS 13.0, *) else { return false }
    return UITraitCollection.current.userInterfaceStyle == .dark
}

func DMAdjustImage(_ lightImageName: String) -> UIImage? {
    
    guard isDark else {
        return UIImage(named: lightImageName)
    }

    let darkImage = "\(lightImageName)\(darkImageSuffix)"
    guard let _ = Bundle.main.path(forResource: darkImage, ofType: "png") else {
        print("[ DarkMode ] Light image: \(lightImageName), not found dark image: \(darkImage)")
        return UIImage(named: lightImageName)
    }
    
    return UIImage(named: darkImage)
}

func DMAdjustColor(_ color: DMColor) -> UIColor? {
    return  DMAdjustValue(color.light, color.dark)
}

func DMAdjustString(_ string: DMString) -> String {
    return  DMAdjustValue(string.light, string.dark)!
}

func DMAdjustFloat(_ float: DMFloat) -> Float {
    return  DMAdjustValue(float.light, float.dark)!
}

func DMExchangeImplementations(_ cls: AnyClass?, _ origin: Selector, _ swizz: Selector) {
    
    let originMethod = class_getInstanceMethod(cls, origin)
    let swizzMethod = class_getInstanceMethod(cls, swizz)
    
    guard let _ = originMethod, let _ = swizzMethod else {
        return
    }
    method_exchangeImplementations(originMethod!, swizzMethod!)
}
