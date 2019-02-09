//
//  ViewController.swift
//  demo
//
//  Created by Jesse on 2019/2/3.
//  Copyright © 2019 Jesse. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    private struct Constants {
        static let cellIdentifier = "cell"
    }
    
    let logicController: HomeLogicController = HomeLogicController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Instagram"
        
        tableView.register(MediaCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        
        logicController.loadData { [weak self] result in
            switch result {
            case .success(let (datasource, delegate)):
                self?.tableView.dataSource = datasource
                self?.tableView.delegate = delegate
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
        if logicController.logout() {
            UIApplication.shared.keyWindow?.rootViewController = Router.mainViewController()
        } else {
            /// TODO: handle edge case
        }
    }
}

// Placeholder cell
extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
