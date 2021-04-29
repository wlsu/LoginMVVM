//
//  SCMPTestUITests.swift
//  SCMPTestUITests
//
//  Created by Vincent Su on 25/4/2021.
//

import XCTest

class SCMPTestUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        try super.setUpWithError()
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInputEmailWithoutPassword() throws {

        let emailTextField = app.textFields["loginEmailTextfield"]
        emailTextField.tap()
        emailTextField.typeText("wlsu@gmail.com")
        
        let loginButton = app.buttons["Login"]
        loginButton.tap()
        let alert = app.alerts.element.label
        XCTAssertEqual(alert, "Please input password")

    }
    
    func testInputPasswordWithoutEmail() throws {
        
        let passwordTextField = app.secureTextFields["loginPasswordTextfield"]
        passwordTextField.tap()
        passwordTextField.typeText("834352asdfa")
        
        let loginButton = app.buttons["Login"]
        loginButton.tap()
        let alert = app.alerts.element.label
        XCTAssertEqual(alert, "Please input email")

    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
