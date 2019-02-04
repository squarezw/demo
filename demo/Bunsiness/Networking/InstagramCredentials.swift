//
//  InstagramCredentials.swift
//  demo
//
//  Created by Jesse on 2019/2/3.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation

struct Credentials {
    static let clientID = "a7c3d253654b466187574c3859cd2e7e"
    static let redirectURI = "http://www.doruby.com"
    
    static let timeStamp = formatter.string(from: Date())
    
    private static let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyyMMddHHmmss"
        return f
    }()
}

