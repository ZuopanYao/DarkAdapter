//
//  DMAttributeStore.swift
//  DarkMode
//
//  Created by Harvey on 2021/4/24.
//

import Foundation

class DMAttributeStore {
    
    static let shared = DMAttributeStore()
    
    private init() { }
    private var attributes: [String: [[NSObject: Any?]]] = [:]
    
    subscript(_ key: DMKeys, _ owner: NSObject) -> Any? {
        get { self[key.rawValue, owner] }
        set { self[key.rawValue, owner] = newValue }
    }
    
    subscript(_ key: String, _ owner: NSObject) -> Any? {
        get {
            if attributes[key] == nil {
                return nil
            }
            
            guard let elements = attributes[key]?.filter({ $0.keys.first == owner }), elements.count > 0 else {
                return nil
            }
            
            return elements[0].values.first!
        }
        set {
            if attributes[key] == nil {
                attributes[key] = []
            }
            
            let elements = attributes[key]?.filter{ $0.keys.first != owner } ?? []
            attributes[key] = elements
            attributes[key]?.append([owner : newValue])
        }
    }
}
