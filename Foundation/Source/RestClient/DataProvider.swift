//
//  DataProvider.swift
//  demo
//
//  Created by Jesse on 2019/2/3.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation

public final class DataProvider<T: APIClient> {
    public let client: T
    
    public init(client: T) {
        self.client = client
    }
    
    public var isAuthenticated: Bool {
        return client.isAuthenticated()
    }
    
    @discardableResult
    public func logout() -> Bool {
        return client.logout()
    }
    
    public func login(completion: @escaping () -> ()) throws {
        try client.login(completion: completion)
    }
}
