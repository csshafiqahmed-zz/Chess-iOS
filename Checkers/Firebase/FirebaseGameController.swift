//
// Created by Satish Boggarapu on 2019-02-19.
// Copyright (c) 2019 SatishBoggarapu. All rights reserved.
//

import FirebaseCore
import FirebaseDatabase

public class FirebaseGameController {

    private var firebaseReference: FirebaseReference!
    private var game: Game!

    init() {
        self.firebaseReference = FirebaseReference()
        self.game = Game.getInstance()
    }

    /// Creates a new game in Firebase and sets value
    public func createNewGame() {
        let data: [String: Any?] = [FirebaseKey.GAME_PLAYER1: game.player1Name,
                                    FirebaseKey.GAME_PLAYER2: game.player2Name,
                                    FirebaseKey.GAME_TURN: game.isPlayer1Turn]

        firebaseReference.getGameReference(game.gameUid!).setValue(data)
    }

    /// Deletes the provided game node from firebase
    public func deleteGameFromFirebase(_ gameUid: String) {
        firebaseReference.getGameReference(gameUid).removeValue()
    }

    /// Checks if user can enter a game with uid
    public func isGameUidValid(_ gameUid: String, completion: @escaping ((FirebaseJoinGameCompletion) -> Void)) {
        let gameReference = firebaseReference.getGameReference(gameUid).child(FirebaseKey.GAME_PLAYER2)
        gameReference.observeSingleEvent(of: .value) { (gameSnapshot: DataSnapshot) in
            if gameSnapshot.exists() {
                completion(.success)
                return
            }
            completion(.failure)
        }
    }
    
    ///
    public func fetchGame(_ gameUid: String, completion: @escaping ((FirebaseFetchGameCompletion) -> Void)) {
        let gameReference = firebaseReference.getGameReference(gameUid)
        gameReference.observeSingleEvent(of: .value) { (gameSnapshot: DataSnapshot) in
            if gameSnapshot.exists() {
                completion(.success(gameSnapshot))
                return
            }
            completion(.failure)
        }
    } 
    
    /// Set player 2 name in Firebase
    public func pushPlayer2ToFirebase(_ gameUid: String) {
        let gameReference = firebaseReference.getGameReference(gameUid)
        gameReference.child(FirebaseKey.GAME_PLAYER2).setValue(game.player2Name)
    }
}
