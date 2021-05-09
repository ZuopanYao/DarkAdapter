//
//  DATextView.swift
//  DarkAdapter
//
//  Created by Harvey on 2021/5/8.
//

import UIKit

extension DADarkBasics where Base: UITextView {
    
    public var textColor: DAColor? {
        get { attributeStore[.textColor, self.base] as? DAColor }
        set {
            attributeStore[.textColor, self.base] = newValue
            base.updateDisplay()
        }
    }
}

extension UITextView {
    
    override class func swizzlingMoment() {
        DAExchangeImplementations(UITextView.self,
                                  #selector(UITextView.traitCollectionDidChange(_:)),
                                  #selector(UITextView.daUITextView_traitCollectionDidChange(_:)))
    }
    
     @objc func daUITextView_traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.daUITextView_traitCollectionDidChange(previousTraitCollection)
        updateDisplay()
    }
    
    override func updateDisplay() {
        super.updateDisplay()
        
        if let color = da.textColor {
            textColor = isDark ? color.dark : color.light
        }
    }
}
