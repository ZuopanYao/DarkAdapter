//
//  DADarkBasics.swift
//  DarkMode
//
//  Created by Harvey on 2021/4/22.
//

import UIKit

/// Defualt is "_dark"
public var darkImageSuffix: String = "_dark"

public struct DADarkBasics<Base> {
    
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public protocol DADarkBasicsCompatible {
    
    associatedtype CompatibleType
    var da: DADarkBasics<CompatibleType> { get set }
}

public extension DADarkBasicsCompatible {
    
    var da: DADarkBasics<Self> {
        get { DADarkBasics(self) }
        set { }
    }
}

extension NSObject: DADarkBasicsCompatible { }

public func DAAdjustValue<Base>(_ light: Base?, _ dark: Base?) -> Base? {
    return  isDark ? dark : light
}

// MARK: - Only internal access
let attributeStore = DAAttributeStore.shared

var isDark: Bool {
    guard #available(iOS 13.0, *) else { return false }
    return UITraitCollection.current.userInterfaceStyle == .dark
}

func DAAdjustImage(_ lightImageName: String) -> UIImage? {
    
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

func DAAdjustColor(_ color: DAColor) -> UIColor? {
    return  DAAdjustValue(color.light, color.dark)
}

func DAAdjustString(_ string: DAString) -> String {
    return  DAAdjustValue(string.light, string.dark)!
}

func DAAdjustFloat(_ float: DAFloat) -> Float {
    return  DAAdjustValue(float.light, float.dark)!
}

func DAExchangeImplementations(_ cls: AnyClass?, _ origin: Selector, _ swizz: Selector) {
    
    let originMethod = class_getInstanceMethod(cls, origin)
    let swizzMethod = class_getInstanceMethod(cls, swizz)
    
    guard let _ = originMethod, let _ = swizzMethod else {
        return
    }
    method_exchangeImplementations(originMethod!, swizzMethod!)
}
