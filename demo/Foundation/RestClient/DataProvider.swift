//
//  DataProvider.swift
//  demo
//
//  Created by Jesse on 2019/2/3.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation

final class DataProvider {
    let client: APIClient & InstagramAPI
    
    init(client: APIClient & InstagramAPI) {
        self.client = client
    }
    
    var isAuthenticated: Bool {
        return client.isAuthenticated()
    }
    
    @discardableResult
    func logout() -> Bool {
        return client.logout()
    }
    
    func login(completion: @escaping () -> ()) throws {
        try client.login(completion: completion)
    }
}
