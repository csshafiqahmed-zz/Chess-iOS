//
// Created by Satish Boggarapu on 2019-02-19.
// Copyright (c) 2019 SatishBoggarapu. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseDatabase

public class FirebaseReference {

    public let databaseReference: DatabaseReference!

    init() {
        self.databaseReference = Database.database().reference()
    }

    /// Reference to the head of GAME node
    public func gameReference() -> DatabaseReference {
        return databaseReference.child(FirebaseKey.GAME)
    }

    /// Reference to a game given it gameUid
    public func getGameReference(_ gameUid: String) -> DatabaseReference {
        return gameReference().child(gameUid)
    }
}