//
//  demoTests.swift
//  demoTests
//
//  Created by Jesse on 2019/2/3.
//  Copyright © 2019 Jesse. All rights reserved.
//

import XCTest
import SwiftInstagram
import ASFoundation

@testable import demo

class MyRecentMediaTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJSONMapping() throws {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let media = try decoder.decode(InstagramMedia.self, from: MyRecentMediaTests.jsonData())
        
        XCTAssertEqual(media.user.fullName, "Square")
        XCTAssertEqual(media.id, "1451112338257994872_649864412")
    }
    
    func testHomeLogicController() {
        let homeVC = HomeViewController()
        homeVC.logicController.provider = DataProvider(client: MockClient())
        homeVC.loadData()
        
        XCTAssertNotNil(homeVC.tableView.dataSource)
        let dataSource = homeVC.tableView.dataSource!
        XCTAssertTrue(dataSource is TableViewDataSource<MediaViewModel, MediaCell>)
        XCTAssertTrue(homeVC.tableView.numberOfRows(inSection: 0) == 1, "number of rows is not match")
    }
    
    fileprivate static func jsonData() throws -> Data {
        let bundle = Bundle(for: self)
        
        guard let url = bundle.url(forResource: "MyRecentMedia", withExtension: "json") else {
            throw(APIError.invalidURL(url: "MyRecentMedia.json"))
        }
        return try Data(contentsOf: url)
    }

}

class MockClient: InstagramClient {
    override func myRecentMedia(completion: @escaping (Result<[InstagramMedia]>) -> ()) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let media = try decoder.decode(InstagramMedia.self, from: MyRecentMediaTests.jsonData())
            completion(.success([media]))
        } catch {
            XCTAssertTrue(false, "file decode failure!")
        }
    }
}
