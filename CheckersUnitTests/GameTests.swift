//
//  GameTests.swift
//  CheckersUnitTests
//
//  Created by Satish Boggarapu on 2/26/19.
//  Copyright © 2019 SatishBoggarapu. All rights reserved.
//

import XCTest
@testable import Checkers

class GameTests: XCTestCase {
    
    var game: Game!

    override func setUp() {
        game = Game.getInstance()
    }

    override func tearDown() {
        game = nil
    }
    
    func testSetMethods() {
        game.setGameUid("123456")
        game.setPlayer1Name("Player1")
        game.setPlayer2Name("Player2")
        game.setIsPlayer1(true)
        
        XCTAssertEqual(game.gameUid!, "123456")
        XCTAssertEqual(game.player1Name!, "Player1")
        XCTAssertEqual(game.player2Name!, "Player2")
        XCTAssertEqual(game.isPlayer1, true)
        XCTAssertEqual(game.isPlayer1Turn, true)
    }

    func testRefreshGameMethod1() {
        game.setGameUid("169628")
        let completeException1 = expectation(description: "Completed")
        
        game.refreshGame {
            XCTAssertEqual(self.game.gameUid, "169628")
            XCTAssertEqual(self.game.player1Name, "Player1")
            XCTAssertEqual(self.game.player2Name, "Player2")
            XCTAssertEqual(self.game.isPlayer1, true)
            XCTAssertEqual(self.game.isPlayer1Turn, true)
            completeException1.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testRefreshGameMethod2() {
        game.setGameUid("111111")
        let completeException1 = expectation(description: "Completed")
        
        game.refreshGame {
            completeException1.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testRefreshGameMethod3() {
        let completeException1 = expectation(description: "Completed")
        let firebaseReference = FirebaseReference()
        firebaseReference.getGameReference("169628").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                self.game.refreshGame(dataSnapshot: snapshot)
                XCTAssertEqual(self.game.gameUid!, "169628")
                XCTAssertEqual(self.game.player1Name!, "Player1")
                XCTAssertEqual(self.game.player2Name!, "Player2")
                XCTAssertEqual(self.game.isPlayer1, true)
                XCTAssertEqual(self.game.isPlayer1Turn, true)
                
                completeException1.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testStartGame() {
        game.startNewGame("Player1")
        XCTAssertEqual(game.player1Name, "Player1")
    }
    
    func testResetGame() {
        game.resetGame()
        
        XCTAssertEqual(game.player1Name, nil)
        XCTAssertEqual(game.player2Name, nil)
        XCTAssertEqual(game.gameUid, nil)
        XCTAssertEqual(game.isPlayer1Turn, true)
    }
    
    func testTogglePlayersTurn() {
        XCTAssertEqual(game.isPlayer1Turn, true)
        
        game.togglePlayersTurn()
        XCTAssertEqual(game.isPlayer1Turn, false)
    }
    
    func testCanPlayerSelectCell() {
        game.startNewGame("Player1")
        
        let actualResult = game.canPlayerSelectCell(row: 0, col: 0)
        XCTAssertEqual(actualResult, false)
        
        let actualResult2 = game.canPlayerSelectCell(row: 7, col: 7)
        XCTAssertEqual(actualResult2, true)
        
        let actualResult3 = game.canPlayerSelectCell(row: 7, col: 0)
        XCTAssertEqual(actualResult3, false)
    }
    
    func testGetPossibleMoves() {
        game.startNewGame("Player1")
        game.setGameUid("169628")
        
        let completeException = expectation(description: "Completed")
        game.refreshGame {
            let moves1 = self.game.getPossibleMovesForPiece(row: 5, col: 5)
            XCTAssertEqual(moves1.count, 0)
            
            let move2 = self.game.getPossibleMovesForPiece(row: 0, col: 2)
            XCTAssertEqual(move2.count, 1)
            
            let move3 = self.game.getPossibleMovesForPiece(row: 2, col: 4)
            XCTAssertEqual(move3.count, 1)
            
            let move4 = self.game.getPossibleMovesForPiece(row: 1, col: 7)
            XCTAssertEqual(move4.count, 1)
            
            let move5 = self.game.getPossibleMovesForPiece(row: 4, col: 0)
            XCTAssertEqual(move5.count, 1)
            
            completeException.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testMovePiece() {
        game.startNewGame("Player1")
        game.setGameUid("169628")
        
        let completeException = expectation(description: "Completed")
        game.refreshGame {
            
            self.game.movePiece(Move(moveType: .normal, moveFromIndexPath: IndexPath(item: 2, section: 0), moveToIndexPath: IndexPath(item: 1, section: 1)))
            
            self.game.movePiece(Move(moveType: .kill, moveFromIndexPath: IndexPath(item: 4, section: 0), moveToIndexPath: IndexPath(item: 2, section: 2), killPieceIndexPath: IndexPath(item: 3, section: 1)))
            
            self.game.movePiece(Move(moveType: .normalPromotion, moveFromIndexPath: IndexPath(item: 1, section: 7), moveToIndexPath: IndexPath(item: 0, section: 6)))
            
//            self.game.movePiece(Move(moveType: .killPromotion, moveFromIndexPath: IndexPath(item: 2, section: 4), moveToIndexPath: IndexPath(item: 0, section: 6), killPieceIndexPath: IndexPath(item: 1, section: 5)))
            
            completeException.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testPlayer1Won() {
        game.resetGame()
        game.startNewGame("Player1")
        for (k, v) in game.board.pieces {
            if !v.isPlayer1 {
                game.board.removePiece(k)
            }
        }
        
        XCTAssertEqual(game.board.getPlayer1KillCount(), 12)
        
        let win = game.didAPlayerWin()
        XCTAssertEqual(win, Win.PLAYER1)
    }

    func testPlayer2Won() {
        game.resetGame()
        game.startNewGame("Player1")
        for (k, v) in game.board.pieces {
            if v.isPlayer1 {
                game.board.removePiece(k)
            }
        }
        
        XCTAssertEqual(game.board.getPlayer2KillCount(), 12)
        
        let win = game.didAPlayerWin()
        XCTAssertEqual(win, Win.PLAYER2)
    }
    
    func testGameInProgress() {
        game.resetGame()
        game.startNewGame("Player1")
        game.board.removePiece("0,0")
        game.board.removePiece("0,2")
        game.board.removePiece("0,4")
        game.board.removePiece("0,6")
        game.board.removePiece("1,1")
        game.board.removePiece("1,3")
        game.board.removePiece("1,5")
        game.board.removePiece("1,7")
        
        let win = game.didAPlayerWin()
        XCTAssertEqual(win, Win.GAME_IN_PROGRESS)
    }
    
    
}
