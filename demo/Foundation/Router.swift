//
//  Router.swift
//  demo
//
//  Created by Jesse on 2019/2/3.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation
import SwiftInstagram

class Router {
    static func mainViewController() -> UIViewController {
        let api = Instagram.shared
//        api.logout()
        
        if api.isAuthenticated {
            return HomeViewController()
        } else {
            return AuthViewController()
        }
    }
}
