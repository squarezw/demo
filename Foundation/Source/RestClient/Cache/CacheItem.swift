//
//  CacheItem.swift
//  demo
//
//  Created by Jesse on 2019/2/17.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation

protocol CacheItemProtocol {
    associatedtype T
    var data: T { get }
    var aliveTill: Date? { get }
}

final class CacheItem<T>: CacheItemProtocol {
    var data: T
    var aliveTill: Date?
    
    init(data: T, aliveTill: Date?) {
        self.data = data
        self.aliveTill = aliveTill
    }
}
