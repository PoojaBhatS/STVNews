//
//  STV_NewsUITests.swift
//  STV NewsUITests
//
//  Created by Pooja Harsha on 26/11/18.
//  Copyright © 2018 Pooja. All rights reserved.
//

import XCTest

class STV_NewsUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTopStories() {
        let app = XCUIApplication()
        Thread.sleep(forTimeInterval: 2.0)
        app.cells["topStoriesTable.cell.2"].tap()
        Thread.sleep(forTimeInterval: 2.0)
        app.navigationBars["STV_News.STVStoryDetailView"].buttons["Top Stories"].tap()
        app.cells["topStoriesTable.cell.4"].tap()
        Thread.sleep(forTimeInterval: 2.0)
        app.navigationBars["STV_News.STVStoryDetailView"].buttons["Top Stories"].tap()
    }

}
