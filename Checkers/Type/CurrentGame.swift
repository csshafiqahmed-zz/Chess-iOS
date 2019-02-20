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

    private init() { }

    public static func getInstance() -> Game {
        if game == nil {
            game = Game()
        }
        return game
    }

    public func startNewGame(_ name: String) {
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

    public func setPlayer1Name(_ name: String) {
        self.player1Name = name
    }

    public func setPlayer2Name(_ name: String) {
        self.player2Name = name
    }

    public func togglePlayersTurn() {
        isPlayer1Turn = !isPlayer1Turn
    }

}