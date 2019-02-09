//
//  AuthLogicController.swift
//  demo
//
//  Created by Jesse on 2019/2/4.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation

class AuthLogicController: LogicControllerWithDataProvider {
    
    @discardableResult
    func logout() -> Bool {
        return provider.logout()
    }
    
    func isAuthenticated() -> Bool {
        return provider.isAuthenticated
    }
    
    func auth(completion: @escaping () -> ()) throws {
        try provider.login(completion: completion)
    }
}
