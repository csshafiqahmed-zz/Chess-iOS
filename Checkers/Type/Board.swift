//
// Created by Satish Boggarapu on 2019-02-20.
// Copyright (c) 2019 SatishBoggarapu. All rights reserved.
//

import Foundation
import FirebaseDatabase

public class Board {

    public private(set) var pieces: [String: Tile]!

    init() {
        pieces = [String: Tile]()
        addPlayer1Pieces()
        addPlayer2Pieces()
    }

    init(snapshot: DataSnapshot) {
        pieces = [String: Tile]()
        for child in snapshot.children.allObjects as! [DataSnapshot] {
            pieces[child.key] = Tile(firebaseKey: child.key, firebaseValue: child.value as! String)
        }
    }

    private func addPlayer1Pieces() {
        for row in stride(from: 7, to: 4, by: -1) {
            for col in stride(from: 0, to: 8, by: 1) {
                let sum = row + col
                if sum % 2 == 0 {
                    pieces["\(row),\(col)"] = Tile(row: row, col: col, isKing: false, isPlayer1: true)
                }
            }
        }
    }

    private func addPlayer2Pieces() {
        for row in stride(from: 0, to: 3, by: 1) {
            for col in stride(from: 0, to: 8, by: 1) {
                let sum = row + col
                if sum % 2 == 0 {
                    pieces["\(row),\(col)"] = Tile(row: row, col: col, isKing: false, isPlayer1: false)
                }
            }
        }
    }

    public func getTileForRowCol(row: Int, col: Int) -> Tile? {
        return pieces["\(row),\(col)"]
    }

    public func convertToFirebase() -> [String: String] {
        var data = [String: String]()
        pieces.forEach { key, value in
            data[key] = getValueString(value)
        }
        return data
    }

    public func getValueString(_ tile: Tile) -> String {
        if tile.isKing {
            return (tile.isPlayer1) ? FirebaseKey.PLAYER1_KING_PIECE : FirebaseKey.PLAYER2_KING_PIECE
        }
        return (tile.isPlayer1) ? FirebaseKey.PLAYER1_PIECE : FirebaseKey.PLAYER2_PIECE
    }
}