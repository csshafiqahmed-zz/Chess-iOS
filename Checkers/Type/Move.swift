//
// Created by Satish Boggarapu on 2019-02-24.
// Copyright (c) 2019 SatishBoggarapu. All rights reserved.
//

import Foundation

public enum MoveType {
    case normal
    case kill
    case normalPromotion
    case killPromotion
}

public class Move {

    public private(set) var moveType: MoveType!
    public private(set) var moveFromIndexPath: IndexPath!
    public private(set) var moveToIndexPath: IndexPath!
    public private(set) var killPieceIndexPath: IndexPath?

    init(moveType: MoveType, moveFromIndexPath: IndexPath, moveToIndexPath: IndexPath, killPieceIndexPath: IndexPath? = nil) {
        self.moveType = moveType
        self.moveFromIndexPath = moveFromIndexPath
        self.moveToIndexPath = moveToIndexPath
        self.killPieceIndexPath = killPieceIndexPath
    }
}
