//
//  IconTests.swift
//  CheckersUnitTests
//
//  Created by Satish Boggarapu on 2/26/19.
//  Copyright © 2019 SatishBoggarapu. All rights reserved.
//

import XCTest
@testable import Checkers

class IconTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCrownIcon() {
        let actualResult = Icon.crown_24
        let expectedResult = UIImage(named: "ic_crown_24dp")?.withRenderingMode(.alwaysTemplate)
        XCTAssertTrue(actualResult == expectedResult)
    }

}
