//
//  PictureCellModel.swift
//  demo
//
//  Created by Jesse on 2019/2/5.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation
import SwiftInstagram

final class MediaViewModel {
    let media: InstagramMedia
    
    var username: String {
        return media.user.fullName
    }
    
    var avatar: URL {
        return media.user.profilePicture
    }
    
    var picture: URL {
        return media.images.standardResolution.url
    }
    
    var pictureWidth: Int {
        return media.images.standardResolution.width
    }
    
    var pictureHeight: Int {
        return media.images.standardResolution.height
    }
    
    init(media: InstagramMedia) {
        self.media = media
    }
    
}
