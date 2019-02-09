//
//  AuthViewController.swift
//  demo
//
//  Created by Jesse on 2019/2/4.
//  Copyright © 2019 Jesse. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController, Componentable {
    let logicController = AuthLogicController()
    
    let authBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Authenticate", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.addTarget(self, action: #selector(auth), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let logoutBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Logout", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.addTarget(self, action: #selector(logout), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Authenticate"
        setupComponents()
    }
    
    func addComponents() {
        
        if logicController.isAuthenticated() {
            [logoutBtn].forEach(view.addSubview)
        } else {
            [authBtn].forEach(view.addSubview)
        }
    }
    
    func layoutComponents() {
        
        var button: UIButton?
        
        if logicController.isAuthenticated() {
            button = logoutBtn
        } else {
            button = authBtn
        }
        
        guard let centerButton = button else {
            return
        }
        
        // button
        let topAnchor = centerButton.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomAnchor = centerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leadingAnchor = centerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingAnchor = centerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        NSLayoutConstraint.activate([topAnchor, bottomAnchor,leadingAnchor,trailingAnchor])
    }
    
    @objc
    private func auth() {
        
        do {
            try logicController.auth(completion: {
                Router.shared.gotoHomePage()
            })
        } catch let error {
            print(error)
        }
    }
    
    @objc
    private func logout() {
        
        logicController.logout()
    }
}
