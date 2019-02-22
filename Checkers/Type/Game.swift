//
// Created by Satish Boggarapu on 2019-02-19.
// Copyright (c) 2019 SatishBoggarapu. All rights reserved.
//

import Foundation

public class Game {

    public static var game: Game!

    public private(set) var gameUid: String?
    public private(set) var player1Name: String?
    public private(set) var player2Name: String?
    public private(set) var isPlayer1Turn: Bool = true
    public private(set) var isPlayer1: Bool = true
    public private(set) var board: Board!

    private init() {
        board = Board()
    }

    public static func getInstance() -> Game {
        if game == nil {
            game = Game()
        }
        return game
    }

    public func refreshGame(completion: @escaping (() -> Void)) {
        let firebaseGameController = FirebaseGameController()
        firebaseGameController.fetchGame(gameUid!) { firebaseFetchGameCompletion in
            switch firebaseFetchGameCompletion {
            case .success(let gameSnapshot):
                self.gameUid = gameSnapshot.key
                self.player1Name = gameSnapshot.childSnapshot(forPath: FirebaseKey.GAME_PLAYER1).value as? String
                self.player2Name = gameSnapshot.childSnapshot(forPath: FirebaseKey.GAME_PLAYER2).value as? String
                self.isPlayer1Turn = gameSnapshot.childSnapshot(forPath: FirebaseKey.GAME_TURN).value as! Bool
                self.board = Board(snapshot: gameSnapshot.childSnapshot(forPath: FirebaseKey.BOARD))
            case .failure:
                print("Failed to refresh game")
            }
            completion()
        }
    }

    public func startNewGame(_ name: String?) {
        let util = Util()
        self.player1Name = name
        self.gameUid = util.generateGameUid()
    }

    public func resetGame() {
        self.player1Name = nil
        self.player2Name = nil
        self.gameUid = nil
        self.isPlayer1Turn = true
    }

    public func setGameUid(_ gameUid: String?) {
        self.gameUid = gameUid
    }

    public func setPlayer1Name(_ name: String?) {
        self.player1Name = name
    }

    public func setPlayer2Name(_ name: String?) {
        self.player2Name = name
    }

    public func setIsPlayer1(_ isPlayer1: Bool) {
        self.isPlayer1 = isPlayer1
    }

    public func togglePlayersTurn() {
        isPlayer1Turn = !isPlayer1Turn
    }

}