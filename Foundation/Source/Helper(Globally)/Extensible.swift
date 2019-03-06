//
//  Extensible.swift
//  Alamofire
//
//  Created by Jesse on 2019/3/3.
//

import Foundation

// some class which is able to extend its responsibility, such as ability of route
public protocol Extensible {
//    associatedtype ExtensibleType
//    var route: ExtensibleType { get }
}

// Route extension

public protocol RouteProtocol {
//    var route: Tree
    func open() // by default: push in navigation controller
    func goback()
}

public extension Extensible {
    var route: Auto<Self> {
        get { return Auto(self) }
    }
}

public struct Auto<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

extension UIViewController: Extensible {}

extension Auto: RouteProtocol where Base:UIViewController {
    public func open() {
        if let navi = self.base.navigationController {
            navi.pushViewController(self.base, animated: true)
        } else {
            // todo: present by Root View Controller
        }
    }
    
    public func goback() {
        if let navi = self.base.navigationController {
            navi.popViewController(animated: true)
        } else {
            // todo: dismiss
        }
    }
}
