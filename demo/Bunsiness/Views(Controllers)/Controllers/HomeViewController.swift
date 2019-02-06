//
//  ViewController.swift
//  demo
//
//  Created by Jesse on 2019/2/3.
//  Copyright © 2019 Jesse. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    let logicController: HomeLogicController = HomeLogicController()
    var dataSource: UITableViewDataSource?
    var delegate: UITableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Instagram"
        
        tableView.register(MediaCell.self, forCellReuseIdentifier: "cell")
        
        logicController.loadData { [weak self] result in
            switch result {
            case .success(let results):
                self?.dataSource = TableViewDataSource.make(for: results)
                self?.delegate = TableViewDelegate.make(for: results)
                self?.tableView.dataSource = self?.dataSource
                self?.tableView.delegate = self?.delegate
                self?.tableView.reloadData()
            case .error(let error):
                print(error)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let doneItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logoutClick))
        navigationItem.rightBarButtonItem = doneItem
    }
    
    @objc
    private func logoutClick() {
        logicController.logout()
    }
}
