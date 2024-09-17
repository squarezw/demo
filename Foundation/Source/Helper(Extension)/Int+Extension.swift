//
//  Int+Extension.swift
//  ASDebugger
//
//  Created by Jesse on 2019/6/15.
//

import Foundation

extension Int {
    func times(_ f: () -> ()) {
        if self > 0 {
            for _ in 0..<self {
                f()
            }
        }
    }

    func times(_ f: @autoclosure () -> ()) {
        if self > 0 {
            for _ in 0..<self {
                f()
            }
        }
    }
}
