//
//  DMDarkBasics.swift
//  DarkMode
//
//  Created by Harvey on 2021/4/22.
//

import UIKit
import RxSwift

var attributeStore: [DMKeys: [NSObject: Any?]] = [:]

let  backgroundScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(queue: DispatchQueue(label: "Observe.UITraitCollection.userInterfaceStyle.Queue"))

let interfaceStyleObserver = Observable<Int>.interval(.milliseconds(500), scheduler: backgroundScheduler)
    .map{ _ -> UIUserInterfaceStyle in
        guard #available(iOS 13.0, *) else { return .light  }
        return UITraitCollection.current.userInterfaceStyle
    }.distinctUntilChanged()

extension UIUserInterfaceStyle {
    var isDark: Bool { self == .dark }
}

public struct DMDarkBasics<Base> {
    
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public protocol DMDarkBasicsCompatible {
    
    associatedtype CompatibleType
    var dm: DMDarkBasics<CompatibleType> { get set }
}

public extension DMDarkBasicsCompatible {
    
    var dm: DMDarkBasics<Self> {
        get {  _ = (self as? NSObject)?.observer; return DMDarkBasics(self) }
        set { }
    }
}

protocol DMInterfaceStyleDidChangeProtocol {
    func interfaceStyleDidChange(_ newStyle: UIUserInterfaceStyle)
}

protocol DMObserverProtocol {
    var observer: DMObserver { get }
}

typealias TargetType = NSObject & DMInterfaceStyleDidChangeProtocol

class DMObserver: NSObject {
    
    var disposeBag: DisposeBag = .init()
    weak var target: TargetType?
    
    convenience init(_ base: TargetType) {
        self.init()
        target = base
        interfaceStyleObserver.subscribe { [self] (event) in
            DispatchQueue.main.async {
                guard let newValue = event.element else { return }
                target?.interfaceStyleDidChange(newValue)
            }
        }.disposed(by: disposeBag)
    }
}

extension NSObject: DMDarkBasicsCompatible { }

var observerStore: [NSObject: DMObserver] = [:]
extension NSObject: DMObserverProtocol {
    
    var observer: DMObserver {
        if let instance = observerStore[self] {
            return instance
        }
        
        let instance = DMObserver(self)
        observerStore[self] = instance
        return instance
    }
}

extension NSObject: DMInterfaceStyleDidChangeProtocol {
   @objc func interfaceStyleDidChange(_ newStyle: UIUserInterfaceStyle) { }
}
