//
//  AccessibilityIdentifier.swift
//  demo
//
//  Created by Jesse on 2019/2/27.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation

/**
 A centralized place to store strings for accessibility identifiers so you
 can refer to them in both the application and tests. These are strings
 which won't be read out loud to the user, so they don't need to be localized.
 */

enum AccessibilityIdentifier: String {
    case
    ErrorTitle = "This is error"
}

/**
 In order to manage all identifier in one place, the following could be changed
 as you want.
 */
