//
//  BaseViewController.swift
//  demo
//
//  Created by Jesse on 2019/2/4.
//  Copyright © 2019 Jesse. All rights reserved.
//

import UIKit

protocol Componentable {
    var components: [UIView] {get}
    
    // Add our components to the view heirarchy.
    func addComponents()
    
    // Remove all components
    func removeComponents()
    
    // Define our autolayout constraints.
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
//        components.forEach {$0.removeFromSuperview()}
    }
}

extension Componentable where Self: UIViewController {
    func addComponents() {
        components.forEach(view.addSubview)
    }
}

protocol ViewModel {
    
}

