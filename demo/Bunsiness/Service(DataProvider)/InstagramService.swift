//
//  InstagramAPI.swift
//  demo
//
//  Created by Jesse on 2019/2/3.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation
import SwiftInstagram

final class InstagramService {
    private let client = InstagramClient.shared
    
    @discardableResult
    func loadFriends(completion: @escaping (Result<[InstagramUser]>) -> ()) -> URLSessionDataTask? {
        
        let friensResource = Resource<[InstagramUser]>(path: "/users")
        
        return client.load(resource: friensResource, completion: completion)
    }
}

// todo: move all concrete APIs impl to here from 3rd party

protocol InstagramAPI {
    func myRecentMedia(completion: @escaping (Result<[InstagramMedia]>) -> ())
    func myProfile(completion: @escaping (Result<InstagramUser>) -> ())
}

extension DataProvider: InstagramAPI where T: InstagramClient {
    func myRecentMedia(completion: @escaping (Result<[InstagramMedia]>) -> ()) {
        client.myRecentMedia(completion: completion)
    }
    
    func myProfile(completion: @escaping (Result<InstagramUser>) -> ()) {
        client.myProfile(completion: completion)
    }
}
