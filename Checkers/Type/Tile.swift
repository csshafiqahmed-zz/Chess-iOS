//
// Created by Satish Boggarapu on 2019-02-20.
// Copyright (c) 2019 SatishBoggarapu. All rights reserved.
//

import Foundation

public class Tile {

    public private(set) var row: Int!
    public private(set) var col: Int!
    public private(set) var isKing: Bool!
    public private(set) var isPlayer1: Bool!

    init(row: Int, col: Int, isKing: Bool, isPlayer1: Bool) {
        self.row = row
        self.col = col
        self.isKing = isKing
        self.isPlayer1 = isPlayer1
    }

    init(firebaseKey: String, firebaseValue: String) {
        let valueArray = Array(firebaseValue)
        let splitString = firebaseKey.split(separator: ",")
        self.row = Int(splitString[0])
        self.col = Int(splitString[1])
        self.isKing = valueArray.first == "K"
        self.isPlayer1 = valueArray.last == "1"
    }

    public func updateTile(row: Int, col: Int, isKing: Bool, isPlayer1: Bool) {
        self.row = row
        self.col = col
        self.isKing = isKing
        self.isPlayer1 = isPlayer1
    }

    public func promotePiece() {
        isKing = true
    }
}