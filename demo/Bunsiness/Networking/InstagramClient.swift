//
//  InstagramClient.swift
//  demo
//
//  Created by Jesse on 2019/2/3.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation
import SwiftInstagram

final class InstagramClient: APIClient, InstagramAPI {
    let api = Instagram.shared
    
    var isAuthenticated: Bool {
        return api.isAuthenticated
    }

    @discardableResult
    func logout() -> Bool {
        return api.logout()
    }
    
    func login(completion: @escaping () -> ()) throws {
        guard let navc = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else {
            throw APIError.unknown
        }
        
        api.login(from: navc, withScopes: [.basic, .publicContent], success: completion) { (error) in
            print("error: \(error)")
        }
    }
    
    func myRecentMedia(completion: @escaping (Result<[InstagramMedia], APIError>) -> ()) {
        api.recentMedia(fromUser: "self", success: { (list) in
            completion(.success(list))
        }) { (error) in
            completion(.error(.http(error)))
        }
    }
    
    func myProfile(completion: @escaping (Result<InstagramUser, APIError>) -> ()) {
        api.user("self", success: { (userList) in
            completion(.success(userList))
        }) { (error) in
            completion(.error(.http(error)))
        }
    }
}
