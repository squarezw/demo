//
//  APIClient.swift
//  demo
//
//  Created by Jesse on 2019/2/3.
//  Copyright © 2019 Jesse. All rights reserved.
//

import Foundation
import Reachability

public typealias JSON = [String: Any]
public typealias HTTPHeaders = [String: String]

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public protocol TokenStore {
    var accessToken: String { get set }
    var refreshToken: String { get set }
}

public protocol APIClient {
    var baseUrl: String { get }
    
    var commonParams: JSON { get }
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T>) -> ()) -> URLSessionDataTask?
    
    func isAuthenticated() -> Bool
    
    func login(completion: @escaping () -> ()) throws
    
    @discardableResult
    func logout() -> Bool
}

public extension APIClient {
    @discardableResult
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T>) -> ()) -> URLSessionDataTask? {
        // Checking internet connection availability
        if Reachability()?.connection == .none {
            completion(.failure(APIError.noInternetConnection))
            return nil
        }
        
        var newResouce = resource
        newResouce.params = newResouce.params.merging(commonParams) { spec, common in
            return spec
        }
        
        // Creating the URLRequest object
        let request = URLRequest(baseUrl: baseUrl, resource: newResouce)

        // Sending request to the server.
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Parsing incoming data
            guard let response = response as? HTTPURLResponse else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(APIError.unknown))
                }
                return
            }
            
            if (200..<300) ~= response.statusCode {
                completion(Result(value: data.flatMap(resource.parse), or: APIError.parseFailure(data: data)))
            } else if response.statusCode == 401 {
                completion(.failure(APIError.unauthorized))
            } else {
                completion(.failure(APIError.http(statusCode: response.statusCode, error)))
            }
        }
        
        task.resume()
        
        return task
    }
}



// MARK: - Helper Extension

extension URL {
    init<T>(baseUrl: String, resource: Resource<T>) {
        var components = URLComponents(string: baseUrl)!
        let resourceComponents = URLComponents(string: resource.path.absolutePath)!
        
        components.path = Path(components.path).appending(path: Path(resourceComponents.path)).absolutePath
        components.queryItems = resourceComponents.queryItems
        
        switch resource.method {
        case .get, .delete:
            var queryItems = components.queryItems ?? []
            queryItems.append(contentsOf: resource.params.map {
                URLQueryItem(name: $0.key, value: String(describing: $0.value))
            })
            components.queryItems = queryItems
        default:
            break
        }
        
        self = components.url!
    }
}

extension URLRequest {
    init<T>(baseUrl: String, resource: Resource<T>) {
        let url = URL(baseUrl: baseUrl, resource: resource)
        self.init(url: url)
        httpMethod = resource.method.rawValue
        resource.headers.forEach{
            setValue($0.value, forHTTPHeaderField: $0.key)
        }
        switch resource.method {
        case .post, .put:
            httpBody = resource.params.percentEscaped().data(using: .utf8)
            // TODO: a Swift issue?
//            httpBody = try! JSONSerialization.data(withJSONObject: resource.params, options: [])
        default:
            break
        }
    }
}

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
            }
            .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

extension KeychainSwift: TokenStore {
    private enum Keys {
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
    }

    public var accessToken: String {
        get { return get(Keys.accessToken) ?? "" }
        set { set(newValue, forKey: Keys.accessToken) }
    }

    public var refreshToken: String {
        get { return get(Keys.refreshToken) ?? "" }
        set { set(newValue, forKey: Keys.refreshToken)}
    }
}
