//
//  UtilTests.swift
//  CheckersUnitTests
//
//  Created by Satish Boggarapu on 2/26/19.
//  Copyright © 2019 SatishBoggarapu. All rights reserved.
//

import XCTest
@testable import Checkers

class UtilTests: XCTestCase {

    var util: Util!
    
    override func setUp() {
        util = Util()
    }

    override func tearDown() {
        util = nil
    }

    func testGenerateGameUid() {
        let uid = util.generateGameUid()
        XCTAssertTrue(uid.count == 6)
    }
    
    func testConvertIndexToKeyWithIndexPath() {
        let indexPath = IndexPath(item: 2, section: 4)
        let actualValue = Util.convertIndexToKey(indexPath)
        let expectedValue = "2,4"
        XCTAssertTrue(actualValue == expectedValue)
    }
    
    func testConvertIndexToKeyWithRowCol() {
        let row = 3
        let col = 4
        let actualValue = Util.convertIndexToKey(row: row, col: col)
        let expectedValue = "3,4"
        XCTAssertTrue(actualValue == expectedValue)
    }

}
