//
//  DMImageView.swift
//  DarkMode
//
//  Created by Harvey on 2021/4/25.
//

import UIKit

extension DMDarkBasics where Base: UIImageView {
    
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

extension UIImageView: DMSwizzlingProtocolOfUIImageView {
    
    public static func swizzlingMomentOfUIImageView() {
        DMExchangeImplementations(UIImageView.self,
                                  #selector(UIImageView.traitCollectionDidChange(_:)),
                                  #selector(UIImageView.dmUIImageView_traitCollectionDidChange(_:)))
    }
    
     @objc func dmUIImageView_traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.dmUIImageView_traitCollectionDidChange(previousTraitCollection)
        updateDisplay()
    }
    
    override func updateDisplay() {
        super.updateDisplay()
        
        if let imageName = dm.image {
            image = DMAdjustImage(imageName)
        }
        
        if let imageName = dm.highlightedImage {
            highlightedImage = DMAdjustImage(imageName)
        }
    }
}
