//
//  DMView.swift
//  DarkMode
//
//  Created by Harvey on 2021/4/22.
//

import UIKit
import RxSwift

public typealias DMColor = (light: UIColor?, dark: UIColor?)

extension DMDarkBasics where Base: UIView {
    
    public var backgroundColor: DMColor? {
        get { attributeStore[.backgroundColor]?[self.base] as? DMColor }
        set { attributeStore[.backgroundColor] = [self.base: newValue] }
    }
}

extension UIView {

    public override func interfaceStyleDidChange(_ newStyle: UIUserInterfaceStyle) {
        super.interfaceStyleDidChange(newStyle)
        backgroundColor = newStyle.isDark ? dm.backgroundColor?.dark : dm.backgroundColor?.light
    }
}
