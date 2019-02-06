//
//  AuthLogicController.swift
//  demo
//
//  Created by Jesse on 2019/2/4.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation

class AuthLogicController {
    let client: APIClient
    
    init(client: APIClient = InstagramClient()) {
        self.client = client
    }
    
    @discardableResult
    func logout() -> Bool {
        return client.logout()
    }
    
    func isAuthenticated() -> Bool {
        return client.isAuthenticated
    }
    
    func auth(completion: @escaping () -> ()) throws {
        try client.login(completion: completion)
    }
}
