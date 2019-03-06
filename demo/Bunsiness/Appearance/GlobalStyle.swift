//
//  GlobalStyle.swift
//  demo
//
//  Created by Jesse on 2019/2/15.
//  Copyright © 2019 Jesse. All rights reserved.
//

import UIKit
import ASFoundation

enum Stylesheet {
    
    enum Default {
        
        static var disableAutoresizing = false
        
        static let title = Style<UILabel> {
            $0.translatesAutoresizingMaskIntoConstraints = disableAutoresizing
            $0.font = .systemFont(ofSize: 12)
            $0.numberOfLines = 0
        }
        
        static let image = Style<UIImageView> {
            $0.translatesAutoresizingMaskIntoConstraints = disableAutoresizing
            $0.contentMode = .scaleAspectFill
            $0.backgroundColor = .gray
        }
        
        static let button = Style<UIButton> {
            $0.translatesAutoresizingMaskIntoConstraints = disableAutoresizing
            $0.setTitleColor(UIColor.gray, for: .normal)
        }
    }
}
