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
    case http(statusCode: Int,  Error?)
    case unknown
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return LocalizedString.noInternetConnection
        case .invalidURL(let url):
            return LocalizedString.invalidURL + url
        case .unauthorized:
            return LocalizedString.unauthorized
        case .parseFailure(let data):
            // TODO: friendly warning
            return LocalizedString.parseFailure + String(describing: data)
        case .http(let statusCode, let error):
            return "\(statusCode)" + (error?.localizedDescription ?? "")
        case .unknown:
            return LocalizedString.unknownError
        }
    }
}
