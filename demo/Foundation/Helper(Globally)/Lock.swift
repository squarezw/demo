//
//  Lock.swift
//  demo
//
//  Created by Jesse on 2019/2/16.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation

/// A simple way like objective-c's using
///
/// - Parameters:
///   - lock: lock object
///   - closure: closure
func synchronized(lock: AnyObject, closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}
