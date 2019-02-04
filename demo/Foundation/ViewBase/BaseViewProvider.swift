//
//  BaseViewController.swift
//  demo
//
//  Created by Jesse on 2019/2/4.
//  Copyright © 2019 Jesse. All rights reserved.
//

import UIKit

protocol Componentable {
    func addComponents()
    func removeComponents()
    func layoutComponents()
}

extension Componentable {
    func setupComponents() {
        addComponents()
        layoutComponents()
    }
    
    func refreshComponents() {
        removeComponents()
        layoutComponents()
    }
    
    func removeComponents() {
        // do nothing
    }
}

protocol ViewModel {
    
}

