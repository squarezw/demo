//
//  LocalizedString.swift
//  demo
//
//  Created by Jesse on 2019/2/27.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation

/**
 A centralized place to store localized strings so you can refer to them
 in both the application and tests.
 
 NOTE: This is an enum instead of a class or a struct so it can't be
 instantiated.
 */

enum LocalizedString {
    //MARK: - Error of strings
    static let error = NSLocalizedString("Error", comment: "Error occurred")
    static let unknownError = NSLocalizedString("Un known Error!", comment: "Un known error occurred")
    static let dataError = NSLocalizedString("Data is invalid!", comment: "Data is invalid")
    static let dataEmpty = NSLocalizedString("No result!", comment: "No result")
    //MARK: - Debug message of strings
}

extension LocalizedString {
    //MARK: - RestClient of strings
    static let noInternetConnection = NSLocalizedString("no internet connection!", comment: "no internet connection!")
    static let invalidURL = NSLocalizedString("URL is not valid!", comment: "URL is not valid!")
    static let unauthorized = NSLocalizedString("unauthorized", comment: "unauthorized")
    static let parseFailure = NSLocalizedString("parseFailure", comment: "parseFailure")
    static let success = NSLocalizedString("success", comment: "success")
    static let failure = NSLocalizedString("failure", comment: "failure")
}

/**
 Extension this enum as you want in order to place all string in one file
 which could be manageable.
 */
