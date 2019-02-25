//
// Created by Satish Boggarapu on 2019-02-20.
// Copyright (c) 2019 SatishBoggarapu. All rights reserved.
//

import UIKit
import SnapKit

class BoardCollectionViewCell: UICollectionViewCell {

    // MARK: Attributes
    private var piece: Piece!

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        piece.snp.makeConstraints { maker in
            maker.left.top.equalToSuperview().offset(4)
            maker.right.bottom.equalToSuperview().inset(4)
        }

    }

    private func setupView() {
        piece = Piece(frame: .zero, type: .RED)
        addSubview(piece)
    }

    public func refreshCell(_ tile: Tile?) {
        if let tile = tile {
            piece.setPieceType((tile.isPlayer1) ? .RED : .BLUE)
            piece.isHidden = false
            piece.toggleKingImage(tile.isKing)
            piece.alpha = 1.0
        } else {
            piece.isHidden = true
            piece.setPieceType((Game.getInstance().isPlayer1Turn) ? .RED : .BLUE)
            piece.toggleKingImage(false)
        }
    }

    public func setPieceType(_ pieceType: PieceType) {
        piece.setPieceType(pieceType)
    }

    public func setPieceIsHidden(_ isHidden: Bool) {
        piece.isHidden = isHidden
    }
    
    public func highlightCell() {
        piece.isHidden = false
        piece.alpha = 0.3
    }
    
    public func highlightPiece() {
        piece.highlightPiece()
    }
}
