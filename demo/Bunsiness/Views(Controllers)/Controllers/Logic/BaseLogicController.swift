//
//  BaseLogicController.swift
//  demo
//
//  Created by Jesse on 2019/2/9.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation

protocol BaseLogicController {
    var provider: DataProvider<InstagramClient> {get}
}

extension BaseLogicController {
    var provider: DataProvider<InstagramClient> {
        get {
            return Router.shared.provider
        }
    }
}
