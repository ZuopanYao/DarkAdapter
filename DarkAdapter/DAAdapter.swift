//
//  DASwizzlingProtocol.swift
//  DarkAdapter
//
//  Created by Harvey on 2021/5/9.
//

import UIKit

protocol DASwizzlingProtocol {
    static func swizzlingMoment()
}

public struct DAAdapter {
    
    static let swizzlingClass: [DASwizzlingProtocol.Type] = { [
        UIView.self,
        UILabel.self,
        UIButton.self,
        UITextView.self,
        UIImageView.self,
        UITextField.self
    ] }()
    
    public static func register() {
        swizzlingClass.forEach { $0.swizzlingMoment() }
    }
}
