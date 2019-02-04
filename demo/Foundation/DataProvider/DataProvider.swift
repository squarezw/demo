//
//  DataProvider.swift
//  demo
//
//  Created by Jesse on 2019/2/3.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case error(E)
}

final class DataProvider {
    private let client: APIClient
    
    init(client: APIClient) {
        self.client = client
    }
}

