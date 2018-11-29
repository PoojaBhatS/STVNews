//
//  STV_NewsTests.swift
//  STV NewsTests
//
//  Created by Pooja Harsha on 26/11/18.
//  Copyright © 2018 Pooja. All rights reserved.
//

import XCTest
@testable import STV_News

class STV_NewsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTopStories() {
        let exp1 = expectation(description: "TopStories")
        let exp2 = self.expectation(description: "ThumbnailURL")
        STVServiceManager.shared.fetchTopStoriesFromAPI { (stories) in
            XCTAssertNotNil(stories, "Success. Loaded Top Stories")
            XCTAssertGreaterThan((stories?.count)!, 0)
            exp1.fulfill()
            guard let imageID = stories?.first?.imageData?.id else {
                return
            }
            STVServiceManager.shared.fetchThumbnailImageURLFromServer(imageID: imageID, completionHandler: { (url) in
                XCTAssertNotNil(url, "Success. Loaded Image URL")
                exp2.fulfill()
            })

        }
        wait(for: [exp1,exp2], timeout: 60)
    }
}
