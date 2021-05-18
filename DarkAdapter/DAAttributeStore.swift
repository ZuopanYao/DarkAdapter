//
//  DAAttributeStore.swift
//  DarkAdapter
//
//  Created by Harvey on 2021/4/24.
//

import Foundation

struct DAValue {
    weak var target: NSObject?
    var value: Any?
    
    init(_ target: NSObject, _ value: Any?) {
        self.target = target
        self.value = value
    }
}

class DAAttributeStore {
    
    static let shared = DAAttributeStore()
    
    private init() { }
    private var attributes: [String: [DAValue]] = [:]
    
    subscript(_ key: DAKeys, _ owner: NSObject) -> Any? {
        get { self[key.rawValue, owner] }
        set { self[key.rawValue, owner] = newValue }
    }
    
    subscript(_ key: String, _ owner: NSObject) -> Any? {
        get {
            if attributes[key] == nil {
                return nil
            }
            
            guard let elements = attributes[key]?.filter({ $0.target == owner }), elements.count > 0 else {
                return nil
            }
            
            return elements[0].value
        }
        set {
            if attributes[key] == nil {
                attributes[key] = []
            }
            
            let elements = attributes[key]?.filter{ $0.target != owner } ?? []
            attributes[key] = elements
            attributes[key]?.append(DAValue(owner, newValue))
        }
    }
}
