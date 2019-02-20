//
// Created by Satish Boggarapu on 2019-02-19.
// Copyright (c) 2019 SatishBoggarapu. All rights reserved.
//

import FirebaseCore
import FirebaseDatabase

public class FirebaseGameController {

    private var firebaseReference: FirebaseReference!

    init() {
        self.firebaseReference = FirebaseReference()
    }

    /// Creates a new game in Firebase and sets value
    public func createNewGame() {
        let game = Game.getInstance()

        let data: [String: Any?] = [FirebaseKey.GAME_PLAYER1: game.player1Name,
                                    FirebaseKey.GAME_PLAYER2: game.player2Name,
                                    FirebaseKey.GAME_TURN: game.isPlayer1Turn]

        firebaseReference.getGameReference(game.gameUid!).setValue(data)
    }

    /// Deletes the provided game node from firebase
    public func deleteGameFromFirebase(_ gameUid: String) {
        firebaseReference.getGameReference(gameUid).removeValue()
    }
}
