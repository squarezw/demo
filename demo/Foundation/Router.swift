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
    static func mainViewController(client: APIClient = InstagramClient()) -> UIViewController {
        if client.isAuthenticated {
            return HomeViewController()
        } else {
            return AuthViewController()
        }
    }
}
