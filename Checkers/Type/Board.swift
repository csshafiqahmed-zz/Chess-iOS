//
// Created by Satish Boggarapu on 2019-02-20.
// Copyright (c) 2019 SatishBoggarapu. All rights reserved.
//

import Foundation

public class Board {

    public private(set) var pieces: [String: Tile]!

    init() {
        pieces = [String: Tile]()
        addPlayer1Pieces()
        addPlayer2Pieces()
    }

    private func addPlayer1Pieces() {
        for row in stride(from: 0, to: 3, by: 1) {
            for col in stride(from: 0, to: 8, by: 1) {
                let sum = row + col
                if sum % 2 == 0 {
                    pieces["\(row),\(col)"] = Tile(row: row, col: col, isKing: false, isPlayer1: true)
                }
            }
        }
    }

    private func addPlayer2Pieces() {
        for row in stride(from: 7, to: 4, by: -1) {
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
}