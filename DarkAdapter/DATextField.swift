//
//  DATextField.swift
//  DarkAdapter
//
//  Created by Harvey on 2021/5/28.
//

import UIKit

extension DADarkBasics where Base: UITextField {
    
    public var textColor: DAColor? {
        get { attributeStore[.textColor, self.base] as? DAColor }
        set {
            attributeStore[.textColor, self.base] = newValue
            base.updateDisplay()
        }
    }
}

extension UITextField {
    
    override class func swizzlingMoment() {
        DAExchangeImplementations(UITextField.self,
                                  #selector(UITextField.traitCollectionDidChange(_:)),
                                  #selector(UITextField.daUITextField_traitCollectionDidChange(_:)))
    }
    
     @objc func daUITextField_traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.daUITextField_traitCollectionDidChange(previousTraitCollection)
        updateDisplay()
    }
    
    override func updateDisplay() {
        super.updateDisplay()
        
        if let color = da.textColor {
            textColor = isDark ? color.dark : color.light
        }
    }
}
