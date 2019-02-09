//
//  demoTests.swift
//  demoTests
//
//  Created by Jesse on 2019/2/3.
//  Copyright © 2019 Jesse. All rights reserved.
//

import XCTest
import SwiftInstagram

@testable import demo

class MyRecentMediaTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJSONMapping() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "MyRecentMedia", withExtension: "json") else {
            XCTFail("Missing file: MyRecentMedia.json")
            return
        }
        let jsonData = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let media = try decoder.decode(InstagramMedia.self, from: jsonData)
        
        XCTAssertEqual(media.user.fullName, "Square")
        XCTAssertEqual(media.id, "1451112338257994872_649864412")
    }
    
    func testHomeLogicController() {
        let provider = DataProvider(client: ClientMock())
//        let authLC = AuthLogicController(provider: provider)
//        let homeLC = HomeLogicController(provider: provider)
//        let homeVC = HomeViewController(logicController: homeLC)
        
//        homeVC.viewDidLoad()
//        XCTAssertTrue(homeVC.tableView.numberOfRows(inSection: 0) == 3)
    }

}

class ClientMock: APIClient {
    var isAuthenticated: Bool
    
    func login(completion: @escaping () -> ()) throws {
        
    }
    
    func logout() -> Bool {
        return true
    }
    
    init() {
        isAuthenticated = false
    }
}
