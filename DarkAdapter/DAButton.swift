//
//  DAButton.swift
//  DarkMode
//
//  Created by Harvey on 2021/4/24.
//

import UIKit

public typealias DAString = (light: String, dark: String)
public typealias DAStateImage = (name: String, state: UIControl.State)
public typealias DAStateColor = (color: DAColor, state: UIControl.State)
public typealias DAStateTitle = (string: DAString, state: UIControl.State)

fileprivate let UIControlStates: [UIControl.State] = [.normal, .highlighted, .disabled, .selected]

extension DADarkBasics where Base: UIButton {
    
    /// Only .normal, .highlighted, .disabled and .selected
    public var image: DAStateImage? {
        get { return nil }
        set {
            guard let _ = newValue else {
                return
            }
            let key = "\(DAKeys.image.rawValue)\(newValue!.state.rawValue)"
            attributeStore[key, self.base] = newValue
            base.updateImageDisplay()
        }
    }
    
    /// Only .normal, .highlighted, .disabled and .selected
    public var backgroundImage: DAStateImage? {
        get { return nil }
        set {
            guard let _ = newValue else {
                return
            }
            let key = "\(DAKeys.backgroundImage.rawValue)\(newValue!.state.rawValue)"
            attributeStore[key, self.base] = newValue
            base.updateBackgroundImageDisplay()
        }
    }
    
    /// Only .normal, .highlighted, .disabled and .selected
    public var title: DAStateTitle? {
        get { return nil }
        set {
            guard let _ = newValue else {
                return
            }
            let key = "\(DAKeys.title.rawValue)\(newValue!.state.rawValue)"
            attributeStore[key, self.base] = newValue
            base.updateTitleDisplay()
        }
    }
    
    /// Only .normal, .highlighted, .disabled and .selected
    public var titleColor : DAStateColor? {
        get { return nil }
        set {
            guard let _ = newValue else {
                return
            }
            let key = "\(DAKeys.titleColor.rawValue)\(newValue!.state.rawValue)"
            attributeStore[key, self.base] = newValue
            base.updateTitleColorDisplay()
        }
    }
}

extension UIButton: DASwizzlingProtocolOfUIButton {
    
    public static func swizzlingMomentOfUIButton() {
        DAExchangeImplementations(UIButton.self,
                                  #selector(UIButton.traitCollectionDidChange(_:)),
                                  #selector(UIButton.daUIButton_traitCollectionDidChange(_:)))
    }
    
    @objc func daUIButton_traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       self.daUIButton_traitCollectionDidChange(previousTraitCollection)
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
        
        let images: [DAStateImage] = match(key: .image, Type: DAStateImage.self)
        images.forEach { (image) in
            setImage(DAAdjustImage(image.name), for: image.state)
        }
    }
    
    fileprivate func updateTitleDisplay() {
        
        let titles: [DAStateTitle] = match(key: .title, Type: DAStateTitle.self)
        titles.forEach { (title) in
            setTitle(DAAdjustString(title.string), for: title.state)
        }
    }
    
    fileprivate func updateTitleColorDisplay() {
        
        let titleColors: [DAStateColor] = match(key: .titleColor, Type: DAStateColor.self)
        titleColors.forEach { (stateSolor) in
            setTitleColor(DAAdjustColor(stateSolor.color), for: stateSolor.state)
        }
    }

    fileprivate func updateBackgroundImageDisplay() {
        
        let images: [DAStateImage] = match(key: .backgroundImage, Type: DAStateImage.self)
        images.forEach { (image) in
            setBackgroundImage(DAAdjustImage(image.name), for: image.state)
        }
    }
    
    fileprivate func match<Base>(key: DAKeys, Type: Base.Type) -> [Base] {
        
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
