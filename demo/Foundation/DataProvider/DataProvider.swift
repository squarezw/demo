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

final class DataProvider {
    let client: APIClient & InstagramAPI
    
    init(client: APIClient & InstagramAPI) {
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

// MARK: - CustomStringConvertible

extension Result: CustomStringConvertible {
    /// The textual representation used when written to an output stream, which includes whether the result was a
    /// success or failure.
    public var description: String {
        switch self {
        case .success:
            return "SUCCESS"
        case .error:
            return "FAILURE"
        }
    }
}

// MARK: - CustomDebugStringConvertible

extension Result: CustomDebugStringConvertible {
    /// The debug textual representation used when written to an output stream, which includes whether the result was a
    /// success or failure in addition to the value or error.
    public var debugDescription: String {
        switch self {
        case .success(let value):
            return "SUCCESS: \(value)"
        case .error(let error):
            return "FAILURE: \(error)"
        }
    }
}
