//
//  NewsBoardTests.swift
//  NewsBoardTests
//
//  Created by Bill Chen on 2020/11/22.
//

import XCTest
@testable import NewsBoard
class NewsBoardTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFeed() throws {
        let c = FeedController()
        let list = c.loadFeedList()
        print("Finished.")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testUserSaver() throws {
        let u = UserController()
        print("Finished")
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
