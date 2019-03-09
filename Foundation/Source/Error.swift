//
//  Error.swift
//  demo
//
//  Created by Jesse on 2019/2/3.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation

public enum ZError: Error {
    case networkingServiceError(reason: APIError)
    case dataError
    case dataEmpty
    case customError(String)
    case unknown
}

extension ZError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .networkingServiceError(let reason):
            return reason.localizedDescription
        case .unknown:
            return LocalizedString.unknownError
        case .dataError:
            return LocalizedString.dataError
        case .dataEmpty:
            return LocalizedString.dataEmpty
        case .customError(let err):
            return err
        }
    }
}
