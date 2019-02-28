//
//  JoinViewControllerUITests.swift
//  CheckersUITests
//
//  Created by Satish Boggarapu on 2/25/19.
//  Copyright © 2019 SatishBoggarapu. All rights reserved.
//

import XCTest

class JoinViewControllerUITests: XCTestCase {

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

    func testJoinGame() {
        let app = XCUIApplication()
        app.textFields["NameTextField"].tap()
        
        let sKey = app/*@START_MENU_TOKEN@*/.keys["S"]/*[[".keyboards.keys[\"S\"]",".keys[\"S\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        sKey.tap()
        let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        let tKey = app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tKey.tap()
        let iKey = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        iKey.tap()
        let sKey2 = app/*@START_MENU_TOKEN@*/.keys["s"]/*[[".keyboards.keys[\"s\"]",".keys[\"s\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        sKey2.tap()
        let hKey = app/*@START_MENU_TOKEN@*/.keys["h"]/*[[".keyboards.keys[\"h\"]",".keys[\"h\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        hKey.tap()
        app.buttons["JoinGame"].tap()
        app.textFields["Enter the game code"].tap()
        app.keys["4"].tap()
        app.keys["5"].tap()
        app.keys["3"].tap()
        app.keys["2"].tap()
        app.keys["1"].tap()
        app.keys["1"].tap()
        
        app.navigationBars["Checkers.JoinGameView"].buttons["Back"].tap()
        app.buttons["JoinGame"].tap()
        app.textFields["Enter the game code"].tap()
        app.keys["4"].tap()
        app.keys["5"].tap()
        app.keys["3"].tap()
        app.keys["2"].tap()
        app.keys["1"].tap()
        app.keys["3"].tap()

    }

}
