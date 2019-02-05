//
//  AuthLogicController.swift
//  demo
//
//  Created by Jesse on 2019/2/4.
//  Copyright © 2019 Jesse. All rights reserved.
//

import UIKit
import SwiftInstagram

class AuthLogicController {
    private let adaptee = Instagram.shared
    
    func isAuthenticated() -> Bool {
        return adaptee.isAuthenticated
    }
    
    @discardableResult
    func logout() -> Bool {
        return adaptee.logout()
    }
    
    // TODO: decouple UIKit
    func auth(navigation navc: UINavigationController, success: @escaping () -> (), failure: @escaping (_ error: Error) -> Void) {
        adaptee.login(from: navc, withScopes: [.basic, .publicContent], success: success, failure: failure)
    }
}
