//
// Created by Satish Boggarapu on 2019-02-20.
// Copyright (c) 2019 SatishBoggarapu. All rights reserved.
//

import UIKit
import SnapKit

class Piece: UIView {

    // MARK: UIElements
    private var view1: UIView!
    private var view2: UIView!
    private var view3: UIView!
    private var crownImageView: UIImageView!

    // MARK: Attributes
    private var pieceType: PieceType!

    init(frame: CGRect, type: PieceType) {
        super.init(frame: frame)

        self.pieceType = type
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let view1Size: CGFloat = self.bounds.width - 6
        let view2Size: CGFloat = view1Size/1.5
        let view3Size: CGFloat = view2Size/2

        view1.addShadow(cornerRadius: view1Size/2)
        view2.addShadow(cornerRadius: view2Size/2)
        view3.addShadow(cornerRadius: view3Size/2)

        view1.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
            maker.size.equalTo(view1Size)
        }

        view2.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
            maker.size.equalTo(view2Size)
        }

        view3.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
            maker.size.equalTo(view3Size)
        }

        crownImageView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }

    private func setupView() {
        view1 = UIView()
        view1.backgroundColor = pieceType.color1
        addSubview(view1)

        view2 = UIView()
        view2.backgroundColor = pieceType.color2
        insertSubview(view2, aboveSubview: view1)

        view3 = UIView()
        view3.backgroundColor = pieceType.color3
        insertSubview(view3, aboveSubview: view2)

        crownImageView = UIImageView()
        crownImageView.image = Icon.crown_24
        crownImageView.tintColor = .white
        crownImageView.contentMode = .scaleAspectFit
        crownImageView.isHidden = true
        view3.addSubview(crownImageView)
    }

    public func setPieceType(_ pieceType: PieceType) {
        self.pieceType = pieceType
        view1.backgroundColor = pieceType.color1
        view2.backgroundColor = pieceType.color2
        view3.backgroundColor = pieceType.color3
    }

    public func toggleKingImage(_ isKing: Bool) {
        crownImageView.isHidden = !isKing
    }

    public func highlightPiece() {
        view1.backgroundColor = pieceType.color1Highlight
        view2.backgroundColor = pieceType.color2Highlight
        view3.backgroundColor = pieceType.color3Highlight
    }
}