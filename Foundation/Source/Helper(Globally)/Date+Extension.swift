//
//  Date+Extension.swift
//  demo
//
//  Created by Jesse on 2019/2/22.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation

extension Date {
    public var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    }
    
    public var afterTomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 2, to: Date())!
    }
    
    // format like `2019-01-01`
    public var simpleDesc: String {
        let timestampFormat: String = "yyyy-MM-dd"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = timestampFormat
        return dateFormatter.string(from: self)
    }
}
