//
//  DMView.swift
//  DarkMode
//
//  Created by Harvey on 2021/4/22.
//

import UIKit

public typealias DMColor = (light: UIColor?, dark: UIColor?)
public typealias DMFloat = (light: Float, dark: Float)

extension DMDarkBasics where Base: UIView {
    
    public var backgroundColor: DMColor? {
        get { attributeStore[.backgroundColor, self.base] as? DMColor }
        set {
            attributeStore[.backgroundColor, self.base] = newValue
            base.updateDisplay()
        }
    }
    
    public var shadowColor: DMColor? {
        get { attributeStore[.shadowColor, self.base] as? DMColor }
        set {
            attributeStore[.shadowColor, self.base] = newValue
            base.updateDisplay()
        }
    }
    
    public var borderColor: DMColor? {
        get { attributeStore[.borderColor, self.base] as? DMColor }
        set {
            attributeStore[.borderColor, self.base] = newValue
            base.updateDisplay()
        }
    }
    
    public var alpha: DMFloat? {
        get { attributeStore[.alpha, self.base] as? DMFloat }
        set {
            attributeStore[.alpha, self.base] = newValue
            base.updateDisplay()
        }
    }
}


extension UIView: DMSwizzlingProtocolOfUIView {
   
    public static func swizzlingMomentOfUIView() {
   
        DMExchangeImplementations(UIView.self,
                                  #selector(UIView.traitCollectionDidChange(_:)),
                                  #selector(UIView.dmUIView_traitCollectionDidChange(_:)))
    }
    
    @objc func dmUIView_traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.dmUIView_traitCollectionDidChange(previousTraitCollection)
        updateDisplay()
    }
    
    @objc func updateDisplay() {

        if let color = dm.backgroundColor {
            backgroundColor = isDark ? color.dark : color.light
        }
        
        if let color = dm.shadowColor {
            layer.shadowColor = (isDark ? color.dark : color.light)?.cgColor
        }
        
        if let color = dm.borderColor {
            layer.borderColor = (isDark ? color.dark : color.light)?.cgColor
        }

        if let alpha = dm.alpha {
            self.alpha = CGFloat(isDark ? alpha.dark : alpha.light)
        }
    }
}
