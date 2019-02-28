//
//  FirebaseGameControllerTests.swift
//  CheckersUnitTests
//
//  Created by Satish Boggarapu on 2/26/19.
//  Copyright © 2019 SatishBoggarapu. All rights reserved.
//

import XCTest
import Firebase
@testable import Checkers

class FirebaseGameControllerTests: XCTestCase {

    var firebaseGameController: FirebaseGameController!
    var game: Game!
    
    override func setUp() {
        firebaseGameController = FirebaseGameController()
        game = Game.getInstance()
    }

    override func tearDown() {
        firebaseGameController = nil
    }
    
    func testCreateNewGame() {
        game.setGameUid("123456")
        game.setPlayer1Name("Player1")
        
        firebaseGameController.createNewGame()
    }
    
    func testDeleteGame() {
        firebaseGameController.deleteGameFromFirebase("123456")
    }
    
    func testIsGameValid() {
        let completedExpectation1 = expectation(description: "Completed")
        let completedExpectation2 = expectation(description: "Completed")
        let completedExpectation3 = expectation(description: "Completed")
    
        firebaseGameController.isGameUidValid("222222") { (result: FirebaseJoinGameCompletion) in
            XCTAssertEqual(result, FirebaseJoinGameCompletion.gameDoesNotExist)
            completedExpectation1.fulfill()
        }
        
        firebaseGameController.isGameUidValid("453213") { (result: FirebaseJoinGameCompletion) in
            XCTAssertEqual(result, FirebaseJoinGameCompletion.gameWaitingForPlayer2)
            completedExpectation2.fulfill()
        }
        
        firebaseGameController.isGameUidValid("169628") { (result: FirebaseJoinGameCompletion) in
            XCTAssertEqual(result, FirebaseJoinGameCompletion.gameInProgress)
            completedExpectation3.fulfill()
        }
        
        firebaseGameController.fetchGame("123456") { (result) in
            
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testFetchGame() {
        let completedExpectation1 = expectation(description: "Completed")
        let completedExpectation2 = expectation(description: "Completed")
        
        firebaseGameController.fetchGame("123456") { (result) in
            completedExpectation1.fulfill()
        }
        
        firebaseGameController.fetchGame("111111") { (result) in
            completedExpectation2.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testPushGame() {
        firebaseGameController.pushGame()
        
        game.setPlayer2Name("Player2")
        firebaseGameController.pushPlayer2ToFirebase("123456")
    }
    

}
