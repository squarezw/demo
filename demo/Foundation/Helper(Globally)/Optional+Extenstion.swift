//
//  Optional+Extenstion.swift
//  demo
//
//  Created by Jesse on 2019/2/4.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation

extension Optional where Wrapped: Collection {
    
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}

infix operator ??= : AssignmentPrecedence

extension Optional {
    
    /// Asigns an optional value to a variable only if the value is not nil.
    static func ??= (lhs: inout Optional, rhs: Optional) {
        guard let rhs = rhs else { return }
        lhs = rhs
    }
}
