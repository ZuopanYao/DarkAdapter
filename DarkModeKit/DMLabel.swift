//
//  DMLabel.swift
//  DarkMode
//
//  Created by Harvey on 2021/4/24.
//

import UIKit

extension DMDarkBasics where Base: UILabel {
    
    public var textColor: DMColor? {
        get { attributeStore[.textColor, self.base] as? DMColor }
        set {
            attributeStore[.textColor, self.base] = newValue
            base.updateDisplay()
        }
    }
}

extension UILabel: DMSwizzlingProtocolOfUILabel {
    
    public static func swizzlingMomentOfUILabel() {
        DMExchangeImplementations(UILabel.self,
                                  #selector(UILabel.traitCollectionDidChange(_:)),
                                  #selector(UILabel.dmUILabel_traitCollectionDidChange(_:)))
    }
    
     @objc func dmUILabel_traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.dmUILabel_traitCollectionDidChange(previousTraitCollection)
        updateDisplay()
    }
    
    override func updateDisplay() {
        super.updateDisplay()
        
        if let color = dm.textColor {
            textColor = isDark ? color.dark : color.light
        }
    }
}
