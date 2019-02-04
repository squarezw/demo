//
//  BaseTableViewProvider.swift
//  demo
//
//  Created by Jesse on 2019/2/4.
//  Copyright © 2019 Jesse. All rights reserved.
//

import UIKit

protocol TableViewModel: ViewModel {
    func height() -> CGFloat
}

// MARK: UITableViewDataSource

class TableViewDataSource<Model>: NSObject, UITableViewDataSource {
    typealias CellConfigurator = (Model, UITableViewCell) -> Void
    
    var models: [Model]
    
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator
    
    init(models: [Model],
         reuseIdentifier: String,
         cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier,
            for: indexPath
        )
        
        cellConfigurator(model, cell)
        
        return cell
    }
}

// MARK: UITableViewDelegate

class TableViewDelegate<Model>: NSObject, UITableViewDelegate {
    typealias HeightConfigurator = (Model) -> CGFloat
    
    var models: [Model]
    
    private let heightConfigurator: HeightConfigurator
    
    init(models: [Model], heightConfigurator: @escaping HeightConfigurator) {
        self.models = models
        self.heightConfigurator = heightConfigurator
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = models[indexPath.row]
        return heightConfigurator(model)
    }
}


