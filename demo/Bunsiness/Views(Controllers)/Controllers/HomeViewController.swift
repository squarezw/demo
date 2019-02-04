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
        
        tableView.register(PictureCell.self, forCellReuseIdentifier: "cell")
        
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
}

// UITableViewDelegate
extension HomeViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
