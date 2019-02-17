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
    let keychain = KeychainSwift(keyPrefix: "PrivateClient_")

    var commonParams: JSON {
        if let token = keychain.get("application_token") {
            return ["token": token]
        } else {
            return [:]
        }
    }
    
    static let shared: InstagramClient = InstagramClient()
    
    var baseUrl: String = "http://localhost:3000/"
    
    private init() {}
    
    func isAuthenticated() -> Bool {
        return api.isAuthenticated
    }
    
    let api = Instagram.shared

    @discardableResult
    func logout() -> Bool {
        return api.logout()
    }
    
    func login(completion: @escaping () -> ()) throws {
        guard let navc = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else {
            throw ZError.unknown
        }
        
        api.login(from: navc, withScopes: [.basic, .publicContent], success: completion) { (error) in
            print("error: \(error)")
        }
    }
    
    func myRecentMedia(completion: @escaping (Result<[InstagramMedia]>) -> ()) {
        api.recentMedia(fromUser: "self", success: { (list) in
            completion(.success(list))
        }) { (error) in
            completion(.failure(APIError.http(error)))
        }
    }
    
    func myProfile(completion: @escaping (Result<InstagramUser>) -> ()) {
        api.user("self", success: { (userList) in
            completion(.success(userList))
        }) { (error) in
            completion(.failure(APIError.unknown))
        }
    }
}
