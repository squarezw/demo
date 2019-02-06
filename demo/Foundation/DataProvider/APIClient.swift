//
//  APIClient.swift
//  demo
//
//  Created by Jesse on 2019/2/3.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation

enum APIError: Error {
    case unknown
    case http(Error)
}

protocol APIClient {
    
    var isAuthenticated: Bool { get }
    
    func login(completion: @escaping () -> ()) throws
    
    @discardableResult
    func logout() -> Bool
}
