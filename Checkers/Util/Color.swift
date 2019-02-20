//
//  Color.swift
//  Checkers
//
//  Created by Satish Boggarapu on 2/5/19.
//  Copyright © 2019 SatishBoggarapu. All rights reserved.
//

import UIKit

extension UIColor {
    static var backgroundColor: UIColor { return UIColor(hex: 0x1b1b1b) } //   212121
    static var highlightColor: UIColor { return UIColor(hex: 0xFF3D00) }

    static var boardDark: UIColor { return UIColor(hex: 0x1b1b1b) }
    static var boardLight: UIColor { return UIColor(hex: 0x333333) }

    static var buttonDisabled: UIColor { return UIColor(hex: 0x9e9e9e) }

    static var lightGrayColor: UIColor { return UIColor (hex: 0x333333) }

    // Piece colors
    static var redPiece1: UIColor { return UIColor (hex: 0xb71c1c) }
    static var redPiece2: UIColor { return UIColor (hex: 0xc62828) }
    static var redPiece3: UIColor { return UIColor (hex: 0xd32f2f) }

    static var bluePiece1: UIColor { return UIColor (hex: 0x0d47a1) }
    static var bluePiece2: UIColor { return UIColor (hex: 0x1565c0) }
    static var bluePiece3: UIColor { return UIColor (hex: 0x1976d2) }

}
