//
//  Foundation+Extension.swift
//  Alamofire
//
//  Created by Jesse on 2019/3/12.
//

import Foundation

public extension Array {
    func anySatisfy(_ p: (Element) -> Bool) -> Bool {
        return !self.allSatisfy { !p($0) }
    }
}
