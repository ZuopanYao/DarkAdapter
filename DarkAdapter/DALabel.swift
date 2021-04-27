//
//  DALabel.swift
//  DarkMode
//
//  Created by Harvey on 2021/4/24.
//

import UIKit

extension DADarkBasics where Base: UILabel {
    
    public var textColor: DAColor? {
        get { attributeStore[.textColor, self.base] as? DAColor }
        set {
            attributeStore[.textColor, self.base] = newValue
            base.updateDisplay()
        }
    }
}

extension UILabel: DASwizzlingProtocolOfUILabel {
    
    public static func swizzlingMomentOfUILabel() {
        DAExchangeImplementations(UILabel.self,
                                  #selector(UILabel.traitCollectionDidChange(_:)),
                                  #selector(UILabel.daUILabel_traitCollectionDidChange(_:)))
    }
    
     @objc func daUILabel_traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.daUILabel_traitCollectionDidChange(previousTraitCollection)
        updateDisplay()
    }
    
    override func updateDisplay() {
        super.updateDisplay()
        
        if let color = da.textColor {
            textColor = isDark ? color.dark : color.light
        }
    }
}
