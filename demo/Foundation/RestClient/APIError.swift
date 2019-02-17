//
//  APIError.swift
//  demo
//
//  Created by Jesse on 2019/2/17.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation

public enum APIError: Error {
    case noInternetConnection
    case invalidURL(url: String)
    case unauthorized
    case parseFailure(data: Data?)
    case http(Error?)
    case unknown
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "no internet connection!"
        case .invalidURL(let url):
            return "URL is not valid: \(url)"
        case .unauthorized:
            return "unauthorized"
        case .parseFailure(let data):
            // TODO: friendly warning
            return "parse failure: \(String(describing: data))"
        case .http(let error):
            return error?.localizedDescription
        case .unknown:
            return "unknown!"
        }
    }
}
