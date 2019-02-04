//
//  APIClient.swift
//  demo
//
//  Created by Jesse on 2019/2/3.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation
import SwiftInstagram

enum APIError: Error {
    case unknown
    case http(Error)
}

protocol APIClient {
    
    func myRecentMedia(completion: @escaping (Result<[InstagramMedia], APIError>) -> ())
    
    func myProfile(completion: @escaping (Result<InstagramUser, APIError>) -> ())
    
}

