//
// Created by Satish Boggarapu on 2019-02-20.
// Copyright (c) 2019 SatishBoggarapu. All rights reserved.
//

import UIKit

public enum PieceType {
    case RED
    case BLUE

    var color1: UIColor {
        switch self {
        case .RED:
            return .redPiece1
        case .BLUE:
            return .bluePiece1
        }
    }

    var color2: UIColor {
        switch self {
        case .RED:
            return .redPiece2
        case .BLUE:
            return .bluePiece2
        }
    }

    var color3: UIColor {
        switch self {
        case .RED:
            return .redPiece3
        case .BLUE:
            return .bluePiece3
        }
    }
}