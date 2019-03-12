//
//  Dependency.swift
//
//  Created by Jesse on 2019/3/9.
//

import Foundation

/**
 Here is dependency managment concept.

 the following will show how manage our dependency as best practice
 */

protocol HasUserDefaults {
    var userDefaults: UserDefaults { get }
}

protocol HasUrlSession {
    var session: URLSession { get }
}

protocol HasRestClient {
    var client: APIClient { get }
}

struct Dependencies: HasUserDefaults, HasUrlSession {
    let userDefaults: UserDefaults
    let session: URLSession

    init(userDefaults: UserDefaults = .init(),
         session: URLSession = .shared) {
        self.userDefaults = userDefaults
        self.session = session
    }
}

protocol DependencyFactory {
    func makeRestClientService() -> APIClient
}

//extension Dependencies: DependencyFactory {
//    func makeRestClientService() -> APIClient {
//        return AnyClient(session: session)
//    }
//}


/// the usage of container of view controller
/// uncomment and copy these code below into your main project.
class ViewController {
    // depends on what you need with Protocol.
    typealias Dependencies = HasUserDefaults & HasUrlSession & HasRestClient

    private let userDefaults: UserDefaults
    private let session: URLSession
    private let client: APIClient

    init(dependencies: Dependencies) {
        userDefaults = dependencies.userDefaults
        session = dependencies.session
        client = dependencies.client
    }
}

//protocol ViewControllerFactory {
//    func makeSearchController() -> SearchViewController
//}

//extension Dependencies: ViewControllerFactory {
//    func makeSearchController() -> SearchViewController {
//        return SearchViewController(
//            client: makeRestClientService()
//        )
//    }
//}

/// Mock Test
class MockedUrlSession: URLSession {}

extension Dependencies {
    static var mocked: Dependencies {
        return Dependencies(userDefaults: UserDefaults(suiteName: #file)!,
                            session: MockedUrlSession())
    }
}
