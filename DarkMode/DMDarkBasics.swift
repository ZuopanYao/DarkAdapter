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
        //print("isDarkInMap = \(UITraitCollection.current.userInterfaceStyle == .dark)")
        return UITraitCollection.current.userInterfaceStyle
    }.distinctUntilChanged()

extension UIUserInterfaceStyle {
    var isDark: Bool { self == .dark }
}

final class DMStore<Base: NSObject> {
    weak var base: Base?
    init(_ base: Base) {
        self.base = base
    }
}

struct DMWeakStore<Element: NSObject> {

    private var items: [DMStore<Element>] = []
    init() { }

    mutating func append(_ element: Element) {
        items.append(DMStore(element))
    }
    
    func contains(_ element: Element) -> Bool {
        return items.filter({ $0.base == element }).count > 0
    }
}

//var weakStore: [NSObject] = []

public struct DMDarkBasics<Base> {
    
    var disposeBag: DisposeBag = .init()
    
    let base: Base
    init(_ base: Base) {
        self.base = base
        subscribe()
    }
    
    func subscribe() {
        
        guard let object = self.base as? NSObject else {
            return
        }
        
//        if weakStore.contains(object) {
//            return
//        }
//
//        weakStore.forEach { (item) in
//            print(CFGetRetainCount(item))
//        }
//        print("DMDarkBasics init")
//
//        weakStore.append(object)
        interfaceStyleObserver
            .subscribe { [self] (event) in
                DispatchQueue.main.async {
                    guard let newValue = event.element else { return }
                    print("isDark = \(newValue.isDark)")
                    interfaceStyleDidChange(newValue)
                }
            }.disposed(by: disposeBag)
    }
    
    func interfaceStyleDidChange(_ newStyle: UIUserInterfaceStyle) {
        
        guard let base = base as? DMInterfaceStyleDidChangeProtocol else {
            return
        }
        base.interfaceStyleDidChange(newStyle)
    }
    
}

public protocol BasicKitCompatible {
    
    associatedtype CompatibleType
    var dm: DMDarkBasics<CompatibleType> { get set }
}

public extension BasicKitCompatible {
    
    var dm: DMDarkBasics<Self> {
        get { DMDarkBasics(self) }
        set { }
    }
}

protocol DMInterfaceStyleDidChangeProtocol {
    func interfaceStyleDidChange(_ newStyle: UIUserInterfaceStyle)
}

extension NSObject: BasicKitCompatible { }
extension NSObject: DMInterfaceStyleDidChangeProtocol {
   @objc func interfaceStyleDidChange(_ newStyle: UIUserInterfaceStyle) { }
}
