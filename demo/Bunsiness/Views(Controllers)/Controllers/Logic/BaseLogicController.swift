//
//  BaseLogicController.swift
//  demo
//
//  Created by Jesse on 2019/2/9.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation

class LogicControllerWithDataProvider {
    private(set) var provider: DataProvider<InstagramClient>
    
    init() {
        self.provider = DataProvider(client: InstagramClient.shared)
    }
}
