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

    /// Adds player 1 pieces to board
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

    /// Adds player 2 pieces to board
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

    /// returns tile if exists for given row and col
    public func getTileForRowCol(row: Int, col: Int) -> Tile? {
        return pieces["\(row),\(col)"]
    }

    /// Converts board object to Firebase Object to be stored in Firebase
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

    /// Return Value string for tile for Firebase value
    public func getValueString(_ tile: Tile) -> String {
        if tile.isKing {
            return (tile.isPlayer1) ? FirebaseKey.PLAYER1_KING_PIECE : FirebaseKey.PLAYER2_KING_PIECE
        }
        return (tile.isPlayer1) ? FirebaseKey.PLAYER1_PIECE : FirebaseKey.PLAYER2_PIECE
    }

    /// Checks if row and cell are valid within bounds of board
    public func isRowColValid(row: Int, col: Int) -> Bool {
        return row >= 0 && row < 8 && col >= 0 && col < 8
    }

    /// Moves piece from one spot to another
    public func movePiece(fromKey: String, toTile: Tile) {
        removePiece(fromKey)
        let key = "\(toTile.row!),\(toTile.col!)"
        pieces[key] = toTile
    }

    /// Removes piece from baord
    public func removePiece(_ key: String) {
        pieces.removeValue(forKey: key)
    }

    /// Converts index for player2 to board transposing
    private func convertIndexForPlayer2(_ key: String) -> String {
        let keyArray = key.split(separator: ",")
        let row = Int(keyArray[0])
        let col = Int(keyArray[1])
        let player2Row = 8 - row! - 1
        let player2Col = 8 - col! - 1
        return "\(player2Row),\(player2Col)"
    }

    /// Promotes piece to King piece
    public func promotePiece(_ key: String) {
        if let piece = pieces[key] {
            piece.promotePiece()
        }
    }

    /// Returns total kill count for player 1
    public func getPlayer1KillCount() -> Int {
        var count = 0
        pieces.forEach { key, value in
            if !value.isPlayer1 {
                count += 1
            }
        }
        return 12 - count
    }

    /// Returns total kill count for player 2
    public func getPlayer2KillCount() -> Int {
        var count = 0
        pieces.forEach { key, value in
            if value.isPlayer1 {
                count += 1
            }
        }
        return 12 - count
    }
}