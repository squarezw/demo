//
//  HomeLogicController.swift
//  demo
//
//  Created by Jesse on 2019/2/4.
//  Copyright © 2019 Jesse. All rights reserved.
//

import UIKit
import ASFoundation

class HomeLogicController: LogicControllerWithDataProvider {
    func loadData(completion: @escaping (Result<(UITableViewDataSource?, UITableViewDelegate?)>) -> ()) {
        provider.myRecentMedia { result in
            switch result {
            case .success(let results):
                // transfer Model -> ViewModel
                let wrapper = results.map { MediaViewModel(media: $0) }                
                completion(.success((TableViewDataSource.make(for: wrapper), TableViewDelegate.make(for: wrapper))))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func logout() -> Bool {
        return provider.logout()
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
