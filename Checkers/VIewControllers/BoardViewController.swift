//
// Created by Satish Boggarapu on 2019-02-05.
// Copyright (c) 2019 SatishBoggarapu. All rights reserved.
//

import UIKit
import SnapKit

class BoardViewController: UIViewController {

    // MARK: UIElements
    private var collectionView: UICollectionView!
    private var topView: UIView!
    private var player1Piece: Piece!
    private var player1Label: UILabel!
    private var player1CounterLabel: UILabel!
    private var player2Piece: Piece!
    private var player2Label: UILabel!
    private var player2CounterLabel: UILabel!

    // MARK: Attributes
    private var game: Game!
    private let boardSize = UIScreen.main.bounds.width - 24

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .backgroundColor
        navigationController?.setNavigationBarHidden(true, animated: false)
        game = Game.getInstance()

        setupView()
        addConstraints()
    }

    private func addConstraints() {

        collectionView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(64)
            maker.size.equalTo(boardSize)
        }

        topView.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview()
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            maker.bottom.equalTo(collectionView.snp.top).offset(-36)
        }

        player1Piece.snp.makeConstraints { maker in
            maker.left.top.equalToSuperview().offset(16)
            maker.size.equalTo(48)
        }

        player1Label.snp.makeConstraints { maker in
            maker.centerY.equalTo(player1Piece.snp.centerY)
            maker.left.equalTo(player1Piece.snp.right).offset(8)
            maker.height.equalTo(player1Label.intrinsicContentSize.height)
            maker.width.equalTo(player1Label.intrinsicContentSize.width)
        }

        player2Piece.snp.makeConstraints { maker in
            maker.right.equalToSuperview().inset(16)
            maker.top.equalToSuperview().offset(16)
            maker.size.equalTo(48)
        }

        player2Label.snp.makeConstraints { maker in
            maker.centerY.equalTo(player2Piece.snp.centerY)
            maker.right.equalTo(player2Piece.snp.left).offset(-8)
            maker.height.equalTo(player2Label.intrinsicContentSize.height)
            maker.width.equalTo(player2Label.intrinsicContentSize.width)
        }
    }

    private func setupView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BoardCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.addShadow(cornerRadius: 4, color: UIColor.boardLight.cgColor)
        collectionView.layer.borderWidth = 1
        collectionView.layer.borderColor = UIColor.boardLight.cgColor
        view.addSubview(collectionView)

        topView = UIView()
        topView.backgroundColor = .lightGrayColor
        topView.addShadow(cornerRadius: 4)
        view.addSubview(topView)

        player1Piece = Piece(frame: .zero, type: .RED)
        topView.addSubview(player1Piece)

        player1Label = UILabel()
        player1Label.text = "Player1"
        player1Label.textColor = .white
        player1Label.textAlignment = .left
        player1Label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        topView.addSubview(player1Label)

        player2Piece = Piece(frame: .zero, type: .BLUE)
        topView.addSubview(player2Piece)

        player2Label = UILabel()
        player2Label.text = "Player2"
        player2Label.textColor = .white
        player2Label.textAlignment = .left
        player2Label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        topView.addSubview(player2Label)

    }
}

extension BoardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 8
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BoardCollectionViewCell else { return UICollectionViewCell() }

        let sum = indexPath.section + indexPath.item
        if sum % 2 == 0 {
            cell.backgroundColor = .boardDark
        } else {
            cell.backgroundColor = .boardLight
        }

        cell.refreshCell(game.board.getTileForRowCol(row: indexPath.item, col: indexPath.section))

        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = boardSize/8.0
        return CGSize(width: cellSize, height: cellSize)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
