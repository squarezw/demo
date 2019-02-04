//
//  HomeLogicController.swift
//  demo
//
//  Created by Jesse on 2019/2/4.
//  Copyright © 2019 Jesse. All rights reserved.
//

import UIKit
import SwiftInstagram

class HomeLogicController {
    let client: APIClient
    var items: [InstagramMedia] = []
    
    init(client: APIClient = InstagramClient()) {
        self.client = client
    }
    
    func loadData(completion: @escaping (Result<[InstagramMedia], APIError>) -> ()) {
        client.myRecentMedia { [weak self] result in
            switch result {
            case .success(let results):
                self?.items = results
            case .error(let error):
                print(error)
            }
            completion(result)
        }
    }
}

extension TableViewDataSource where Model == InstagramMedia {
    static func make(for media: [InstagramMedia],
                     reuseIdentifier: String = "cell") -> TableViewDataSource {
        return TableViewDataSource(
            models: media,
            reuseIdentifier: reuseIdentifier
        ) { (message, cell) in
            cell.textLabel?.text = message.id
            cell.detailTextLabel?.text = message.filter
        }
    }
}

extension TableViewDelegate where Model == InstagramMedia {
    static func make(for media: [InstagramMedia]) -> TableViewDelegate {
        return TableViewDelegate(models: media, heightConfigurator: { (medium) -> CGFloat in
            return CGFloat(medium.images.lowResolution.height)
        })
    }
}
