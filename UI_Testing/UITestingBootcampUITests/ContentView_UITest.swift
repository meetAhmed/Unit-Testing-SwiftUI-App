//
//  ContentView_UITest.swift
//  UITestingBootcampUITests
//
//  Created by Ahmed Ali on 22/02/2023.
//

import XCTest

// Naming: test_[struct]_[ui_component]_[expected_result]

final class ContentView_UITest: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ContentView_signUpBtn_shouldSignIn() {
        app.textFields["SignUpTextField"].tap()
        app.keys["A"].tap()
        app.keys["b"].tap()
        app.keys["c"].tap()
        app.buttons["Return"].tap()
        app.buttons["SignUpButton"].tap()
        XCTAssertTrue(app.navigationBars["Welcome"].exists)
    }
    
    func test_ContentView_signUpBtn_shouldNotSignIn() {
        app.textFields["SignUpTextField"].tap()
        app.buttons["Return"].tap()
        app.buttons["SignUpButton"].tap()
        XCTAssertFalse(app.navigationBars["Welcome"].exists)
    }
    
    func test_SignedInHomeView_showAlertButton_shouldDisplayAndDimissAlert() {
        app.textFields["SignUpTextField"].tap()
        app.keys["A"].tap()
        app.keys["b"].tap()
        app.keys["c"].tap()
        app.buttons["Return"].tap()
        app.buttons["SignUpButton"].tap()
        XCTAssertTrue(app.navigationBars["Welcome"].exists)
        app.buttons["WelcomeAlertButton"].tap()
        sleep(1)
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists)
        sleep(1)
        alert.buttons["OK"].tap()
        sleep(1)
        XCTAssertFalse(alert.exists)
    }
}
