//
//  Error.swift
//  demo
//
//  Created by Jesse on 2019/2/3.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation

enum ZError: Error {
    case invalidURL(url: String)
}

extension ZError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL(let url):
            return "URL is not valid: \(url)"
        }
    }
}
