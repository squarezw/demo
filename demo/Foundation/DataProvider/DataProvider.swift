//
//  DataProvider.swift
//  demo
//
//  Created by Jesse on 2019/2/3.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case error(E)
}

final class DataProvider<T: APIClient> {
    let client: T
    
    init(client: T) {
        self.client = client
    }
    
    var isAuthenticated: Bool {
        return client.isAuthenticated
    }
    
    @discardableResult
    func logout() -> Bool {
        return client.logout()
    }
    
    func login(completion: @escaping () -> ()) throws {
        try client.login(completion: completion)
    }
}

