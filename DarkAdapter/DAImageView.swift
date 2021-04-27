//
//  DAImageView.swift
//  DarkMode
//
//  Created by Harvey on 2021/4/25.
//

import UIKit

extension DADarkBasics where Base: UIImageView {
    
    public var image: String? {
        get { attributeStore[.image, self.base] as? String }
        set {
            attributeStore[.image, self.base] = newValue
            base.updateDisplay()
        }
    }
    
    public var highlightedImage: String? {
        get { attributeStore[.highlightedImage, self.base] as? String }
        set {
            attributeStore[.highlightedImage, self.base] = newValue
            base.updateDisplay()
        }
    }
}

extension UIImageView: DASwizzlingProtocolOfUIImageView {
    
    public static func swizzlingMomentOfUIImageView() {
        DAExchangeImplementations(UIImageView.self,
                                  #selector(UIImageView.traitCollectionDidChange(_:)),
                                  #selector(UIImageView.daUIImageView_traitCollectionDidChange(_:)))
    }
    
     @objc func daUIImageView_traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.daUIImageView_traitCollectionDidChange(previousTraitCollection)
        updateDisplay()
    }
    
    override func updateDisplay() {
        super.updateDisplay()
        
        if let imageName = da.image {
            image = DAAdjustImage(imageName)
        }
        
        if let imageName = da.highlightedImage {
            highlightedImage = DAAdjustImage(imageName)
        }
    }
}
