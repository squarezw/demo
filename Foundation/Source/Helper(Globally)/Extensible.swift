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

public struct Auto<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

// MARK: Extensible func for UIViewController
public extension Extensible where Self: UIViewController {
    var route: Auto<Self> {
        get { return Auto(self) }
    }
}

extension UIViewController: Extensible {}

// MARK: Route Protocol, it's like a tree
public protocol RouteProtocol {
    associatedtype T: Routable
//    var parent: RouteProtocol? { get }
//    var children: [RouteProtocol] { get }
    
    func insert(node: T)
    func delete(node: T)
//    func go(to: RouteProtocol)
}

// Node value protocol, be compatible with View / ViewController
public protocol Routable {
    
    func present()
    func dismiss()
}

extension UIViewController: Routable {
    public func present() {
        
    }
    
    public func dismiss() {
        self.navigationController?.popViewController(animated: true)
        // or dismiss by presentation type
    }
}

extension UINavigationController: RouteProtocol {
    public func insert(node: UIViewController) {
        self.pushViewController(node, animated: true)
    }
    
    public func delete(node: UIViewController) {
        if node.navigationController == self {
            self.popViewController(animated: true)
        }
    }
}

extension UITabBarController: RouteProtocol {
    public func insert(node: UIViewController) {
        self.viewControllers?.append(node)
    }
    
    public func delete(node: UIViewController) {
        guard let index = self.viewControllers?.firstIndex(of: node) else { return }
        self.viewControllers?.remove(at: index)
    }
}
