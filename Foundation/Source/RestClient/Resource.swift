//
//  Resource.swift
//  demo
//
//  Created by Jesse on 2019/2/17.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation

public struct Resource<T> {
    let path: Path
    let method: RequestMethod
    var headers: HTTPHeaders
    var params: JSON
    let parse: (Data) -> T?
    
    public init(path: String,
         method: RequestMethod = .get,
         params: JSON = [:],
         headers: HTTPHeaders = [:],
         parse: @escaping (Data) -> T?) {
        
        self.path = Path(path)
        self.method = method
        self.params = params
        self.headers = headers
        self.parse = parse
    }
}

extension Resource where T: Decodable {
    public init(jsonDecoder: JSONDecoder = JSONDecoder(),
         path: String,
         method: RequestMethod = .get,
         params: JSON = [:],
         headers: HTTPHeaders = [:]) {
        
        var newHeaders = headers
        newHeaders["Accept"] = "application/json"
//        newHeaders["Content-Type"] = "application/json"
        
        self.path = Path(path)
        self.method = method
        self.params = params
        self.headers = newHeaders
        self.parse = {
            do {
                return try jsonDecoder.decode(T.self, from: $0)
            } catch let error {
                print(ZError.customError(error.localizedDescription))
                return nil
            }
        }
    }
}
