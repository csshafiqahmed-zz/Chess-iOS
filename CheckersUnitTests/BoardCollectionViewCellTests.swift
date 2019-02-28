//
//  BoardCollectionViewCellTests.swift
//  CheckersUnitTests
//
//  Created by Satish Boggarapu on 2/26/19.
//  Copyright © 2019 SatishBoggarapu. All rights reserved.
//

import XCTest
@testable import Checkers

class BoardCollectionViewCellTests: XCTestCase {

    var cell: BoardCollectionViewCell!
    
    override func setUp() {
        cell = BoardCollectionViewCell(frame: .zero)
        cell.layoutSubviews()
    }

    override func tearDown() {
        cell = nil
    }
    
    func testRefreshCell() {
        var tile = Tile(row: 0, col: 0, isKing: true, isPlayer1: true)
        cell.refreshCell(tile)
        
        tile = Tile(firebaseKey: "2,4", firebaseValue: "P1")
        cell.refreshCell(tile)
        
        tile.updateTile(row: 0, col: 6, isKing: true, isPlayer1: false)
        tile.promotePiece()
        cell.refreshCell(tile)
        
        cell.refreshCell(nil)
    }
    
    func testSetMethods() {
        cell.setPieceType(PieceType.RED)
        cell.setPieceIsHidden(true)
        cell.highlightCell()
        cell.highlightPiece()
        
        cell.setPieceType(PieceType.BLUE)
        cell.setPieceIsHidden(false)
        cell.highlightCell()
        cell.highlightPiece()
    }

}
