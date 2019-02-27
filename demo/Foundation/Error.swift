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
    case unknown
}

extension ZError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .networkingServiceError(let reason):
            return reason.localizedDescription
        case .unknown:
            return LocalizedString.unknownError
        }
    }
}
