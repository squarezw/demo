//
//  BaseLogicController.swift
//  demo
//
//  Created by Jesse on 2019/2/9.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation
import ASFoundation

class LogicControllerWithDataProvider {
    var provider: DataProvider<InstagramClient>
    
    init() {
        self.provider = DataProvider(client: InstagramClient.shared)
    }
}
