//
//  Cache.swift
//  demo
//
//  Created by Jesse on 2019/2/17.
//  Copyright © 2019 Jesse. All rights reserved.
//

import UIKit

public class Cache {
    
    public typealias T = Any
    
    public static let shared: Cache = Cache()
    
    public static var defaultExpireTimeInterval = 60 * 60.0
    
    private var sessionCache: NSCache<AnyObject, CacheItem<T>> = NSCache<AnyObject, CacheItem<T>>()
    
    private init() {
        NotificationCenter.default.addObserver(self, selector: #selector(clearSessionCache), name: UIApplication.didReceiveMemoryWarningNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func clearSessionCache() {
        sessionCache.removeAllObjects()
    }
    
    public func cachedObject(forKey cacheKey: String) -> Any? {
        guard let cacheItem = (sessionCache.object(forKey: cacheKey as AnyObject)) else {
            return nil
        }
        
        if let aliveTill = cacheItem.aliveTill, aliveTill.compare(Date()) == .orderedAscending {
            sessionCache.removeObject(forKey: cacheItem)
            return nil
        }
        
        return cacheItem.data
    }
    
    public func cacheObject(_ data: T, forKey cacheKey: String, aliveDuration: TimeInterval = defaultExpireTimeInterval) {
        
        let cacheItem = CacheItem(data: data, aliveTill: Date().addingTimeInterval(aliveDuration))
        
        sessionCache.setObject(cacheItem, forKey: cacheKey as AnyObject)
    }
    
    public func deleteCache(forKey cacheKey: String) {
        guard let cacheItem = (sessionCache.object(forKey: cacheKey as AnyObject)) else {
            return
        }
        
        sessionCache.removeObject(forKey: cacheItem)
    }
}
