//
//  DMButton.swift
//  DarkMode
//
//  Created by Harvey on 2021/4/24.
//

import UIKit

public typealias DMString = (light: String, dark: String)
public typealias DMStateImage = (name: String, state: UIControl.State)
public typealias DMStateColor = (color: DMColor, state: UIControl.State)
public typealias DMStateTitle = (string: DMString, state: UIControl.State)

fileprivate let UIControlStates: [UIControl.State] = [.normal, .highlighted, .disabled, .selected]

extension DMDarkBasics where Base: UIButton {
    
    /// Only .normal, .highlighted, .disabled and .selected
    public var image: DMStateImage? {
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
    public var backgroundImage: DMStateImage? {
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
    
    /// Only .normal, .highlighted, .disabled and .selected
    public var title: DMStateTitle? {
        get { return nil }
        set {
            guard let _ = newValue else {
                return
            }
            let key = "\(DMKeys.title.rawValue)\(newValue!.state.rawValue)"
            attributeStore[key, self.base] = newValue
            base.updateTitleDisplay()
        }
    }
    
    /// Only .normal, .highlighted, .disabled and .selected
    public var titleColor : DMStateColor? {
        get { return nil }
        set {
            guard let _ = newValue else {
                return
            }
            let key = "\(DMKeys.titleColor.rawValue)\(newValue!.state.rawValue)"
            attributeStore[key, self.base] = newValue
            base.updateTitleColorDisplay()
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
        updateTitleDisplay()
        updateTitleColorDisplay()
        updateBackgroundImageDisplay()
    }
    
    fileprivate func updateImageDisplay() {
        
        let images: [DMStateImage] = match(key: .image, Type: DMStateImage.self)
        images.forEach { (image) in
            setImage(DMAdjustImage(image.name), for: image.state)
        }
    }
    
    fileprivate func updateTitleDisplay() {
        
        let titles: [DMStateTitle] = match(key: .title, Type: DMStateTitle.self)
        titles.forEach { (title) in
            setTitle(DMAdjustString(title.string), for: title.state)
        }
    }
    
    fileprivate func updateTitleColorDisplay() {
        
        let titleColors: [DMStateColor] = match(key: .titleColor, Type: DMStateColor.self)
        titleColors.forEach { (stateSolor) in
            setTitleColor(DMAdjustColor(stateSolor.color), for: stateSolor.state)
        }
    }

    fileprivate func updateBackgroundImageDisplay() {
        
        let images: [DMStateImage] = match(key: .backgroundImage, Type: DMStateImage.self)
        images.forEach { (image) in
            setBackgroundImage(DMAdjustImage(image.name), for: image.state)
        }
    }
    
    fileprivate func match<Base>(key: DMKeys, Type: Base.Type) -> [Base] {
        
        var bases: [Base] = []
        UIControlStates.forEach { (state) in
            
            let key = "\(key.rawValue)\(state.rawValue)"
            guard let base = attributeStore[key, self] as? Base else {
                return
            }
            bases.append(base)
        }
        return bases
    }
}
