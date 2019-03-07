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
    
    enum Page {
        case HomeView
        case AuthView
    }
    
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
    
    func goto(_ page: Page) {
        switch page {
        case .HomeView:
            guard root.go(to: HomeViewController.self) else {
                root.insert(node: HomeViewController())
                return
            }
            break
        case .AuthView:
            guard root.go(to: AuthViewController.self) else {
                root.insert(node: AuthViewController())
                return
            }
            break
        }
    }
}
