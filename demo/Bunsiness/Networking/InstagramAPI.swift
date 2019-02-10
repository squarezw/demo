//
//  InstagramAPI.swift
//  demo
//
//  Created by Jesse on 2019/2/3.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation
import SwiftInstagram

// todo: move all concrete APIs impl to here from 3rd party

protocol InstagramAPI {
    func myRecentMedia(completion: @escaping (Result<[InstagramMedia], APIError>) -> ())
    func myProfile(completion: @escaping (Result<InstagramUser, APIError>) -> ())
}

extension DataProvider: InstagramAPI {
    func myRecentMedia(completion: @escaping (Result<[InstagramMedia], APIError>) -> ()) {
        client.myRecentMedia(completion: completion)
    }
    
    func myProfile(completion: @escaping (Result<InstagramUser, APIError>) -> ()) {
        client.myProfile(completion: completion)
    }
}
