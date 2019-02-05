//
//  Media.swift
//  demo
//
//  Created by Jesse on 2019/2/5.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation
import SwiftInstagram

extension InstagramMedia : Equatable {}

public func == (lhs: InstagramMedia, rhs: InstagramMedia) -> Bool {
    return lhs.id == rhs.id
        && lhs.user.username == rhs.user.username
        && lhs.images.standardResolution.url == rhs.images.standardResolution.url
        && lhs.createdDate == rhs.createdDate
        && lhs.comments.count == rhs.comments.count
}
