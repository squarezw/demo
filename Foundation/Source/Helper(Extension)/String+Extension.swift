//
//  Foundation+Extenstion.swift
//  demo
//
//  Created by Jesse on 2019/2/4.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    var MD5: String? {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        guard let data = self.data(using: String.Encoding.utf8) else { return nil }
        let hash = data.withUnsafeBytes { (bytes: UnsafePointer<Data>) -> [UInt8] in
            var hash: [UInt8] = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes, CC_LONG(data.count), &hash)
            return hash
        }
        return (0..<length).map { String(format: "%02x", hash[$0]) }.joined()
    }
    
    public var date: Date? {
        let timestampFormat: String = "yyyy-MM-dd'T'HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = timestampFormat
        return dateFormatter.date(from: self)
    }
}
