//
//  Result.swift
//  demo
//
//  Created by Jesse on 2019/2/17.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation

public enum Result<T> {
    case success(T)
    case failure(Error)
    
    var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
}

extension Result {
    init(value: T?, or error: Error) {
        guard let value = value else {
            self = .failure(error)
            return
        }
        
        self = .success(value)
    }
}

// MARK: - CustomStringConvertible

extension Result: CustomStringConvertible {
    /// The textual representation used when written to an output stream, which includes whether the result was a
    /// success or failure.
    public var description: String {
        switch self {
        case .success:
            return LocalizedString.success
        case .failure:
            return LocalizedString.failure
        }
    }
}

// MARK: - CustomDebugStringConvertible

extension Result: CustomDebugStringConvertible {
    /// The debug textual representation used when written to an output stream, which includes whether the result was a
    /// success or failure in addition to the value or error.
    public var debugDescription: String {
        switch self {
        case .success(let value):
            return LocalizedString.success + "\(value)"
        case .failure(let error):
            return LocalizedString.failure + "\(error)"
        }
    }
}
