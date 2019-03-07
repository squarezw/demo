//
//  Route.swift
//  demo
//
//  Created by Jesse on 2019/3/3.
//  Copyright © 2019 Jesse. All rights reserved.
//

import UIKit
import ASFoundation

protocol AuthDelegate {
    func isAuthenticated() -> Bool
}

class Router {
    static let shared: Router = Router()
    
    lazy var root: UINavigationController = {
        return UINavigationController(rootViewController: rootViewController())
    }()
    
    var delegate: AuthDelegate?
    
    private func rootViewController() -> UIViewController {
        if let delegate = delegate, delegate.isAuthenticated() {
            return HomeViewController()
        } else {
            return AuthViewController()
        }
    }
    
    /// once user login or logout, the root should be rebuild.
    func refresh() {
        root = UINavigationController(rootViewController: rootViewController())
        UIApplication.shared.keyWindow?.rootViewController = root
    }
    
    func gotoAuthPage() {
        if let vc = root.viewControllers.first(where: { $0 is AuthViewController } ) {
            root.popToViewController(vc, animated: true)
        } else {
            root.pushViewController(AuthViewController(), animated: true)
        }
    }
    
    func gotoHomePage() {
        if let vc = root.viewControllers.first(where: { $0 is HomeViewController } ) {
            root.popToViewController(vc, animated: true)
        } else {
            root.pushViewController(HomeViewController(), animated: true)
        }
    }
}
