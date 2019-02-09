//
//  HomeLogicController.swift
//  demo
//
//  Created by Jesse on 2019/2/4.
//  Copyright © 2019 Jesse. All rights reserved.
//

import UIKit

class HomeLogicController {
    private let client: InstagramClient
    
    private var dataSource: UITableViewDataSource?
    private var delegate: UITableViewDelegate?
    
    init(client: InstagramClient = InstagramClient()) {
        self.client = client
    }
    
    func loadData(completion: @escaping (Result<(UITableViewDataSource?, UITableViewDelegate?), APIError>) -> ()) {
        client.myRecentMedia { [weak self] result in
            switch result {
            case .success(let results):
                // transfer Model -> ViewModel
                let wrapper = results.map { MediaViewModel(media: $0) }
                
                self?.dataSource = TableViewDataSource.make(for: wrapper)
                self?.delegate = TableViewDelegate.make(for: wrapper)
                completion(.success((self?.dataSource, self?.delegate)))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
    
    func logout() -> Bool {
        return client.logout()
    }
}

extension TableViewDataSource where Model == MediaViewModel, Cell == MediaCell {
    static func make(for media: [MediaViewModel],
                     reuseIdentifier: String = "cell") -> TableViewDataSource {
        return TableViewDataSource(
            models: media,
            reuseIdentifier: reuseIdentifier
        ) { (model, cell) in
            cell.viewModel = model
        }
    }
}

extension TableViewDelegate where Model == MediaViewModel {
    static func make(for media: [MediaViewModel]) -> TableViewDelegate {
        return TableViewDelegate(models: media, heightConfigurator: { (medium) -> CGFloat in
            return CGFloat(medium.pictureHeight)
        })
    }
}
