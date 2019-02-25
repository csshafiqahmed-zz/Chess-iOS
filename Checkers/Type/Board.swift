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
            var key = child.key
            if !Game.getInstance().isPlayer1 {
                key = convertIndexForPlayer2(key)
            }
            pieces[key] = Tile(firebaseKey: key, firebaseValue: child.value as! String)
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
            var pieceKey = key
            if !Game.getInstance().isPlayer1 {
                pieceKey = convertIndexForPlayer2(pieceKey)
            }
            data[pieceKey] = getValueString(value)
        }
        return data
    }

    public func getValueString(_ tile: Tile) -> String {
        if tile.isKing {
            return (tile.isPlayer1) ? FirebaseKey.PLAYER1_KING_PIECE : FirebaseKey.PLAYER2_KING_PIECE
        }
        return (tile.isPlayer1) ? FirebaseKey.PLAYER1_PIECE : FirebaseKey.PLAYER2_PIECE
    }
    
    public func isRowColValid(row: Int, col: Int) -> Bool {
        return row >= 0 && row < 8 && col >= 0 && col < 8
    }

    public func movePiece(fromKey: String, toTile: Tile) {
        pieces.removeValue(forKey: fromKey)
        let key = "\(toTile.row!),\(toTile.col!)"
        pieces[key] = toTile
    }

    private func convertIndexForPlayer2(_ key: String) -> String {
        let keyArray = key.split(separator: ",")
        let row = Int(keyArray[0])
        let col = Int(keyArray[1])
        let player2Row = 8 - row! - 1
        let player2Col = 8 - col! - 1
        return "\(player2Row),\(player2Col)"
    }
}