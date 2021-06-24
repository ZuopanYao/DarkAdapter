//
//  DAView.swift
//  DarkAdapter
//
//  Created by Harvey on 2021/4/22.
//

import UIKit

public typealias DAColor = (light: UIColor?, dark: UIColor?)
public typealias DAFloat = (light: Float, dark: Float)

extension DADarkBasics where Base: UIView {
    
    public var backgroundColor: DAColor? {
        get { attributeStore[.backgroundColor, self.base] as? DAColor }
        set {
            attributeStore[.backgroundColor, self.base] = newValue
            base.updateDisplay()
        }
    }
    
    public var shadowColor: DAColor? {
        get { attributeStore[.shadowColor, self.base] as? DAColor }
        set {
            attributeStore[.shadowColor, self.base] = newValue
            base.updateDisplay()
        }
    }
    
    public var borderColor: DAColor? {
        get { attributeStore[.borderColor, self.base] as? DAColor }
        set {
            attributeStore[.borderColor, self.base] = newValue
            base.updateDisplay()
        }
    }
    
    public var tintColor: DAColor? {
        get { attributeStore[.tintColor, self.base] as? DAColor }
        set {
            attributeStore[.tintColor, self.base] = newValue
            base.updateDisplay()
        }
    }
    
    public var alpha: DAFloat? {
        get { attributeStore[.alpha, self.base] as? DAFloat }
        set {
            attributeStore[.alpha, self.base] = newValue
            base.updateDisplay()
        }
    }
    
    public var shadowOpacity: DAFloat? {
        get { attributeStore[.shadowOpacity, self.base] as? DAFloat }
        set {
            attributeStore[.shadowOpacity, self.base] = newValue
            base.updateDisplay()
        }
    }
}

extension UIView: DASwizzlingProtocol {
   
    @objc class func swizzlingMoment() {
        DAExchangeImplementations(UIView.self,
                                  #selector(UIView.traitCollectionDidChange(_:)),
                                  #selector(UIView.daUIView_traitCollectionDidChange(_:)))
    }
    
    @objc func daUIView_traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.daUIView_traitCollectionDidChange(previousTraitCollection)
        updateDisplay()
    }
    
    @objc func updateDisplay() {

        if let color = da.backgroundColor {
            backgroundColor = DAAdjustColor(color)
        }
        
        if let color = da.shadowColor {
            layer.shadowColor = DAAdjustColor(color)?.cgColor
        }
        
        if let color = da.borderColor {
            layer.borderColor = DAAdjustColor(color)?.cgColor
        }
        
        if let color = da.tintColor {
           tintColor = DAAdjustColor(color)
        }

        if let alpha = da.alpha {
            self.alpha = CGFloat(DAAdjustFloat(alpha))
        }
        
        if let opacity = da.shadowOpacity {
            layer.shadowOpacity = DAAdjustFloat(opacity)
        }
    }
}
