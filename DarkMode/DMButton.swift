//
//  DMButton.swift
//  DarkMode
//
//  Created by Harvey on 2021/4/24.
//

import UIKit

public typealias DMImage = (imageName: String, state: UIControl.State)

let UIControlStates: [UIControl.State] = [.normal, .highlighted, .disabled, .selected]

extension DMDarkBasics where Base: UIButton {
    
    /// Only .normal, .highlighted, .disabled and .selected
    public var image: DMImage? {
        get { return nil }
        set {
            guard let _ = newValue else {
                return
            }
            let key = "\(DMKeys.image.rawValue)\(newValue!.state.rawValue)"
            attributeStore[key, self.base] = newValue
            base.updateImageDisplay()
        }
    }
    
    /// Only .normal, .highlighted, .disabled and .selected
    public var backgroundImage: DMImage? {
        get { return nil }
        set {
            guard let _ = newValue else {
                return
            }
            let key = "\(DMKeys.backgroundImage.rawValue)\(newValue!.state.rawValue)"
            attributeStore[key, self.base] = newValue
            base.updateBackgroundImageDisplay()
        }
    }
}

extension UIButton: DMSwizzlingProtocolOfUIButton {
    
    public static func swizzlingMomentOfUIButton() {
        DMExchangeImplementations(UIButton.self,
                                  #selector(UIButton.traitCollectionDidChange(_:)),
                                  #selector(UIButton.dmUIButton_traitCollectionDidChange(_:)))
    }
    
    @objc func dmUIButton_traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       self.dmUIButton_traitCollectionDidChange(previousTraitCollection)
       updateDisplay()
   }
   
    override func updateDisplay() {
        super.updateDisplay()
        updateImageDisplay()
        updateBackgroundImageDisplay()
    }
    
    func updateImageDisplay() {
        
        let images: [DMImage] = matchImage(key: .image)
        images.forEach { (image) in
            setImage(DMAdjustImage(image.imageName), for: image.state)
        }
    }
    
    func updateBackgroundImageDisplay() {
        
        let images: [DMImage] = matchImage(key: .backgroundImage)
        images.forEach { (image) in
            setBackgroundImage(DMAdjustImage(image.imageName), for: image.state)
        }
    }
    
    func matchImage(key: DMKeys) -> [DMImage] {
        
        var images: [DMImage] = []
        UIControlStates.forEach { (state) in
            
            let key = "\(key.rawValue)\(state.rawValue)"
            guard let image = attributeStore[key, self] as? DMImage else {
                return
            }
            images.append(image)
        }
        return images
    }
}
