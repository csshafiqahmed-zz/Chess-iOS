//
// Created by Satish Boggarapu on 2019-02-19.
// Copyright (c) 2019 SatishBoggarapu. All rights reserved.
//

import Foundation
import FirebaseDatabase

public class Game {

    public static var game: Game!

    public private(set) var gameUid: String?
    public private(set) var player1Name: String?
    public private(set) var player2Name: String?
    public private(set) var isPlayer1Turn: Bool = true
    public private(set) var isPlayer1: Bool = true
    public private(set) var board: Board!

    private init() {
        board = Board()
//        gameUid = "386667"
    }

    public static func getInstance() -> Game {
        if game == nil {
            game = Game()
        }
        return game
    }

    public func refreshGame(dataSnapshot: DataSnapshot) {
        gameUid = dataSnapshot.key
        player1Name = dataSnapshot.childSnapshot(forPath: FirebaseKey.GAME_PLAYER1).value as? String
        player2Name = dataSnapshot.childSnapshot(forPath: FirebaseKey.GAME_PLAYER2).value as? String
        isPlayer1Turn = dataSnapshot.childSnapshot(forPath: FirebaseKey.GAME_TURN).value as! Bool
        board = Board(snapshot: dataSnapshot.childSnapshot(forPath: FirebaseKey.BOARD))
    }

    public func refreshGame(completion: @escaping (() -> Void)) {
        let firebaseGameController = FirebaseGameController()
        firebaseGameController.fetchGame(gameUid!) { firebaseFetchGameCompletion in
            switch firebaseFetchGameCompletion {
            case .success(let gameSnapshot):
                self.gameUid = gameSnapshot.key
                self.player1Name = gameSnapshot.childSnapshot(forPath: FirebaseKey.GAME_PLAYER1).value as? String
                self.player2Name = gameSnapshot.childSnapshot(forPath: FirebaseKey.GAME_PLAYER2).value as? String
                self.isPlayer1Turn = gameSnapshot.childSnapshot(forPath: FirebaseKey.GAME_TURN).value as! Bool
                self.board = Board(snapshot: gameSnapshot.childSnapshot(forPath: FirebaseKey.BOARD))
            case .failure:
                print("Failed to refresh game")
            }
            completion()
        }
    }

    public func startNewGame(_ name: String?) {
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

    public func setGameUid(_ gameUid: String?) {
        self.gameUid = gameUid
    }

    public func setPlayer1Name(_ name: String?) {
        self.player1Name = name
    }

    public func setPlayer2Name(_ name: String?) {
        self.player2Name = name
    }

    public func setIsPlayer1(_ isPlayer1: Bool) {
        self.isPlayer1 = isPlayer1
    }

    public func togglePlayersTurn() {
        isPlayer1Turn = !isPlayer1Turn
    }
    
    public func canPlayerSelectCell(row: Int, col: Int) -> Bool {
        if let tile = board.getTileForRowCol(row: row, col: col) {
            return isPlayer1 == tile.isPlayer1 && isPlayer1Turn == isPlayer1
        }
        return false
    }

    public func getPossibleMovesForPiece(row: Int, col: Int) -> [Move] {
        var validMoves = [Move]()
        if let tile = board.getTileForRowCol(row: row, col: col) {
            let possibleMoves = getPossibleMoves(tile)
            for move in possibleMoves {
                let moveTile = board.getTileForRowCol(row: move.row, col: move.col)
                if moveTile == nil  {
                    let moveType = isPromotionMove(row: move.row) ? MoveType.normalPromotion : MoveType.normal
                    let move = Move(moveType: moveType, moveFromIndexPath: IndexPath(item: row, section: col),
                            moveToIndexPath: IndexPath(item: move.row, section: move.col))
                    validMoves.append(move)
                } else if moveTile?.isPlayer1 != isPlayer1 {
                    // Check if opponent piece can be killed
                    let newRow = ((row - move.row) * -1) + move.row
                    let newCol = ((col - move.col) * -1) + move.col
                    if board.isRowColValid(row: newRow, col: newCol) && board.getTileForRowCol(row: newRow, col: newCol) == nil {
                        let moveType = isPromotionMove(row: newRow) ? MoveType.killPromotion : MoveType.kill
                        let move = Move(moveType: moveType, moveFromIndexPath: IndexPath(item: row, section: col),
                                moveToIndexPath: IndexPath(item: newRow, section: newCol), killPieceIndexPath: IndexPath(item: move.row, section: move.col))
                        validMoves.append(move)
                    }
                }
            }
        }
        return validMoves
    }
    
    private func getPossibleMoves(_ tile: Tile) -> [(row: Int, col: Int)] {
        var possibleMoves = [(row: Int, col: Int)]()
        let row = tile.row!
        let col = tile.col!
        if tile.isKing {
            // Move down and left
            if board.isRowColValid(row: row+1, col: col-1) {
                possibleMoves.append((row: row+1, col: col-1))
            }

            // Move down and right
            if board.isRowColValid(row: row+1, col: col+1) {
                possibleMoves.append((row: row+1, col: col+1))
            }
        }

        // Move up and left
        if board.isRowColValid(row: row-1, col: col-1) {
            possibleMoves.append((row: row-1, col: col-1))
        }

        // Move up and right
        if board.isRowColValid(row: row-1, col: col+1) {
            possibleMoves.append((row: row-1, col: col+1))
        }
        return possibleMoves
    }

    private func isPromotionMove(row: Int) -> Bool {
        return row == 0
    }

    public func movePiece(_ move: Move) {
        if let tile = board.getTileForRowCol(row: move.moveFromIndexPath.item, col: move.moveFromIndexPath.section) {
            let newTile = Tile(row: move.moveToIndexPath.item, col: move.moveToIndexPath.section, isKing: tile.isKing, isPlayer1: tile.isPlayer1)
            board.movePiece(fromKey: "\(move.moveFromIndexPath.item),\(move.moveFromIndexPath.section)", toTile: newTile)

            switch move.moveType! {
            case .normal:
                ()
            case .kill:
                board.removePiece(Util.convertIndexToKey(move.killPieceIndexPath!))
                let validMoves = getPossibleMovesForPiece(row: move.moveToIndexPath.item, col: move.moveToIndexPath.section)
                for m in validMoves where m.moveType == .kill || m.moveType == .killPromotion {
                    movePiece(m)
                }
            case .normalPromotion:
                board.promotePiece(Util.convertIndexToKey(move.moveToIndexPath))
            case .killPromotion:
                board.removePiece(Util.convertIndexToKey(move.killPieceIndexPath!))
                board.promotePiece(Util.convertIndexToKey(move.moveToIndexPath))
            }

        }
    }

    public func didAPlayerWin() -> Win {
        if board.getPlayer1KillCount() == 12 {
            return .PLAYER1
        } else if board.getPlayer2KillCount() == 12 {
            return .PLAYER2
        } else {
            return .GAME_IN_PROGRESS
        }
    }

}