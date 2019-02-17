//
//  Router.swift
//  demo
//
//  Created by Jesse on 2019/2/3.
//  Copyright © 2019 Jesse. All rights reserved.
//

import UIKit

class Router {
    static let shared: Router = Router()
    
    private lazy var client: InstagramClient = InstagramClient.shared
    
    lazy var rootVC: UINavigationController = {
        UINavigationController(rootViewController: provider.isAuthenticated ? HomeViewController() : AuthViewController())
    }()
    
    lazy var provider: DataProvider = {
        return DataProvider(client: self.client)
    }()
    
    /// once user login or logout, the root should be rebuild.
    func refresh() {
        rootVC = UINavigationController(rootViewController: provider.isAuthenticated ? HomeViewController() : AuthViewController())        
        UIApplication.shared.keyWindow?.rootViewController = rootVC
    }
    
    func gotoAuthPage() {
        if let vc = rootVC.viewControllers.first(where: { $0 is AuthViewController } ) {
            rootVC.popToViewController(vc, animated: true)
        } else {
            rootVC.pushViewController(AuthViewController(), animated: true)
        }
    }
    
    func gotoHomePage() {
        if let vc = rootVC.viewControllers.first(where: { $0 is HomeViewController } ) {
            rootVC.popToViewController(vc, animated: true)
        } else {
            rootVC.pushViewController(HomeViewController(), animated: true)
        }
    }
}
