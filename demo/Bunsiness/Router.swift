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

class Router: RouteProtocol {
    func open() {
        
    }
    
    func goback() {
        
    }
    
    
    static let shared: Router = Router()
    
    var delegate: AuthDelegate?
    
    private func rootViewController() -> UIViewController {
        if let delegate = delegate, delegate.isAuthenticated() {
            return HomeViewController()
        } else {
            return AuthViewController()
        }
    }
    
    func entryVC() -> UINavigationController {
        return UINavigationController(rootViewController: rootViewController())
    }
    
    /// once user login or logout, the root should be rebuild.
    func refresh() {
        UIApplication.shared.keyWindow?.rootViewController = entryVC()
    }
    
    func gotoAuthPage() {
        if let vc = entryVC().viewControllers.first(where: { $0 is AuthViewController } ) {
            entryVC().popToViewController(vc, animated: true)
        } else {
            entryVC().pushViewController(AuthViewController(), animated: true)
        }
    }
    
    func gotoHomePage() {
        if let vc = entryVC().viewControllers.first(where: { $0 is HomeViewController } ) {
            entryVC().popToViewController(vc, animated: true)
        } else {
            entryVC().pushViewController(HomeViewController(), animated: true)
        }
    }
}
