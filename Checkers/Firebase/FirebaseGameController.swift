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
                                    FirebaseKey.GAME_TURN: game.isPlayer1Turn,
                                    FirebaseKey.BOARD: game.board.convertToFirebase(),
                                    FirebaseKey.PLAYER1_CONNECTED: Date().millisecondsSince1970]

        firebaseReference.getGameReference(game.gameUid!).setValue(data)
    }

    /// Deletes the provided game node from firebase
    public func deleteGameFromFirebase(_ gameUid: String) {
        firebaseReference.getGameReference(gameUid).removeValue()
    }

    /// Checks if user can enter a game with uid
    public func isGameUidValid(_ gameUid: String, completion: @escaping ((FirebaseJoinGameCompletion) -> Void)) {
        let gameReference = firebaseReference.getGameReference(gameUid)
        gameReference.observeSingleEvent(of: .value) { (gameSnapshot: DataSnapshot) in
            if gameSnapshot.exists() {
                if gameSnapshot.childSnapshot(forPath: FirebaseKey.GAME_PLAYER2).exists() {
                    completion(.gameInProgress)
                } else {
                    completion(.gameWaitingForPlayer2)
                }
            } else {
                completion(.gameDoesNotExist)
            }
        }
    }
    
    /// Fetch game from firebase for given UID, once done return the completion handler with result
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

    /// Push game to firebase when a turn ahs taken place by pushing BOARD node and toggling player turn boolean
    public func pushGame() {
        let gameReference = firebaseReference.getGameReference(game.gameUid!)

        gameReference.child(FirebaseKey.GAME_TURN).setValue(game.isPlayer1Turn)
        gameReference.child(FirebaseKey.BOARD).setValue(game.board.convertToFirebase())
    }
    
    /// Set player 2 name in Firebase
    public func pushPlayer2ToFirebase(_ gameUid: String, player2Name: String? = Game.getInstance().player2Name) {
        let gameReference = firebaseReference.getGameReference(gameUid)
        gameReference.child(FirebaseKey.GAME_PLAYER2).setValue(player2Name)
        gameReference.child(FirebaseKey.PLAYER2_CONNECTED).setValue(Date().millisecondsSince1970)
    }

    /// Update place status of connected or not, by checking firebase for last updated value
    public func updatePlayerStatus() {
        guard let uid = game.gameUid  else { return }
        let gameReference = firebaseReference.getGameReference(uid)
        
        if game.isPlayer1 {
            gameReference.child(FirebaseKey.PLAYER1_CONNECTED).setValue(Date().millisecondsSince1970)
        } else {
            gameReference.child(FirebaseKey.PLAYER2_CONNECTED).setValue(Date().millisecondsSince1970)
        }
    }
}
