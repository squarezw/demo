//
//  Test.swift
//  demo
//
//  Created by Jesse on 2024/9/17.
//  Copyright © 2024 Jesse. All rights reserved.
//

import Foundation

var desc: Any {
    let desc: NSAttributedString = NSAttributedString(string: "111")
    
    guard let para = desc.attribute(.paragraphStyle, at: 0, effectiveRange: nil) else {
        return desc
    }

    return para
}
