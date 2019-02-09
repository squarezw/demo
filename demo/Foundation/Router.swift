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
    
    private lazy var client: InstagramClient = InstagramClient()
    
    private lazy var rootVC: UINavigationController = {
        if provider.isAuthenticated {
            return UINavigationController(rootViewController: HomeViewController())
        } else {
            return UINavigationController(rootViewController: AuthViewController())
        }
    }()
    
    lazy var provider: DataProvider = {
        return DataProvider(client: self.client)
    }()
    
    func mainViewController() -> UIViewController {
        return rootVC
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
