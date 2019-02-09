//
//  InstagramAPI.swift
//  demo
//
//  Created by Jesse on 2019/2/3.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation
import SwiftInstagram

class InstagramAPI {
    // todo: move all concrete APIs impl to here from 3rd party
}

extension DataProvider where T == InstagramClient {
    var api: Instagram {
        get {
            return Instagram.shared
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
