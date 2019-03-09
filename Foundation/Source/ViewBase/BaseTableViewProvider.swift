//
//  BaseTableViewProvider.swift
//  demo
//
//  Created by Jesse on 2019/2/4.
//  Copyright © 2019 Jesse. All rights reserved.
//

import UIKit

// MARK: UITableViewDataSource

public class TableViewDataSource<Model, Cell: UITableViewCell>: NSObject, UITableViewDataSource {
    public typealias CellConfigurator = (Model, Cell) -> Void
    
    var models: [Model]
    
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator
    
    public init(models: [Model],
         reuseIdentifier: String,
         cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }
    
    public func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    public func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if cell == nil {
            cell = Bundle.main.loadNibNamed(reuseIdentifier, owner: self, options: nil)?.first as? UITableViewCell
        }
        
        if let `cell` = cell as? Cell {
            cellConfigurator(model, cell)
        }
        
        return cell!
    }
}

// MARK: UITableViewDelegate

public class TableViewDelegate<Model>: NSObject, UITableViewDelegate {
    public typealias HeightConfigurator = (Model) -> CGFloat
    
    var models: [Model]
    
    private let heightConfigurator: HeightConfigurator
    
    public init(models: [Model], heightConfigurator: @escaping HeightConfigurator) {
        self.models = models
        self.heightConfigurator = heightConfigurator
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = models[indexPath.row]
        return heightConfigurator(model)
    }
}


