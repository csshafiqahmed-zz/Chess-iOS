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
    private var titleLabel: UILabel!
    private var player1Piece: Piece!
    private var player1Label: UILabel!
    private var player1CounterLabel: UILabel!
    private var player2Piece: Piece!
    private var player2Label: UILabel!
    private var player2CounterLabel: UILabel!
    private var turnLabel: UILabel!
    private var menuButton: UIButton!

    // MARK: Attributes
    private var firebaseGameController: FirebaseGameController!
    private var firebaseReference: FirebaseReference!
    private var game: Game!
    private var selectedIndexPath: IndexPath?
    private var validMoves: [IndexPath]!
    private let boardSize = UIScreen.main.bounds.width - 24

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .backgroundColor
        navigationController?.setNavigationBarHidden(true, animated: false)
        firebaseGameController = FirebaseGameController()
        firebaseReference = FirebaseReference()
        game = Game.getInstance()
        validMoves = [IndexPath]()

        setupView()
        addConstraints()

        refreshGameState()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        addValueEventListener()
    }

    private func addConstraints() {

        collectionView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(86)
            maker.size.equalTo(boardSize)
        }

        menuButton.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(12)
            maker.right.equalToSuperview().inset(12)
            maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            maker.height.equalTo(52)
        }

        topView.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview()
            maker.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            maker.bottom.equalTo(collectionView.snp.top).offset(-36)
        }

        titleLabel.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview()
            maker.top.equalToSuperview().offset(8)
            maker.height.equalTo(titleLabel.intrinsicContentSize.height)
        }

        player1Piece.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(16)
            maker.top.equalTo(titleLabel.snp.bottom).offset(24)
            maker.size.equalTo(48)
        }

        player1Label.snp.makeConstraints { maker in
            maker.left.equalTo(player1Piece.snp.right).offset(8)
            maker.right.equalTo(view.snp.centerX)
            maker.top.equalTo(player1Piece.snp.top)
            maker.bottom.equalTo(player1Piece.snp.bottom)
        }

        player1CounterLabel.snp.makeConstraints { maker in
            maker.centerX.equalTo(player1Piece.snp.centerX)
            maker.top.equalTo(player1Piece.snp.bottom).offset(8)
            maker.height.equalTo(player1CounterLabel.intrinsicContentSize.height)
            maker.width.equalTo(player1CounterLabel.intrinsicContentSize.width)
        }

        player2Piece.snp.makeConstraints { maker in
            maker.right.equalToSuperview().inset(16)
            maker.top.equalTo(titleLabel.snp.bottom).offset(24)
            maker.size.equalTo(48)
        }

        player2Label.snp.makeConstraints { maker in
            maker.right.equalTo(player2Piece.snp.left).offset(-8)
            maker.left.equalTo(view.snp.centerX)
            maker.top.equalTo(player2Piece.snp.top)
            maker.bottom.equalTo(player2Piece.snp.bottom)
        }

        player2CounterLabel.snp.makeConstraints { maker in
            maker.centerX.equalTo(player2Piece.snp.centerX)
            maker.top.equalTo(player2Piece.snp.bottom).offset(8)
            maker.height.equalTo(player2CounterLabel.intrinsicContentSize.height)
            maker.width.equalTo(player2CounterLabel.intrinsicContentSize.width)
        }

        turnLabel.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview()
            maker.bottom.equalToSuperview().inset(24)
            maker.height.equalTo(turnLabel.snp.height)
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

        titleLabel = UILabel()
        titleLabel.text = "Checkers"
        titleLabel.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        topView.addSubview(titleLabel)

        player1Piece = Piece(frame: .zero, type: .RED)
        topView.addSubview(player1Piece)

        player1Label = UILabel()
        player1Label.text = game.player1Name
        player1Label.textColor = .white
        player1Label.textAlignment = .left
        player1Label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        topView.addSubview(player1Label)

        player1CounterLabel = UILabel()
        player1CounterLabel.text = "0"
        player1CounterLabel.textColor = .white
        player1CounterLabel.textAlignment = .center
        player1CounterLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        topView.addSubview(player1CounterLabel)

        player2Piece = Piece(frame: .zero, type: .BLUE)
        topView.addSubview(player2Piece)

        player2Label = UILabel()
        player2Label.text = game.player2Name
        player2Label.textColor = .white
        player2Label.textAlignment = .right
        player2Label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        topView.addSubview(player2Label)

        player2CounterLabel = UILabel()
        player2CounterLabel.text = "0"
        player2CounterLabel.textColor = .white
        player2CounterLabel.textAlignment = .center
        player2CounterLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        topView.addSubview(player2CounterLabel)

        turnLabel = UILabel()
        turnLabel.text = game.isPlayer1 ? Message.YOUR_TURN : Message.OPPONENT_TURN
        turnLabel.textColor = .white
        turnLabel.textAlignment = .center
        turnLabel.font = UIFont.systemFont(ofSize: 38, weight: .bold)
        topView.addSubview(turnLabel)

        menuButton = UIButton()
        menuButton.backgroundColor = .highlightColor
        menuButton.setTitle("MENU", for: .normal)
        menuButton.setTitleColor(.white, for: .normal)
        menuButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        menuButton.addShadow()
        view.addSubview(menuButton)

    }

    private func refreshGameState() {
        game.refreshGame {
            self.player1Label.text = self.game.player1Name
            self.player2Label.text = self.game.player2Name
            self.collectionView.reloadData()
        }
    }
    
    private func isCellInValidMoves(_ indexPath: IndexPath) -> Bool {
        for index in validMoves where index.item == indexPath.item && index.section == indexPath.section {
            return true
        }
        return false
    }

    private func addValueEventListener() {
        firebaseReference.getGameReference(game.gameUid!).observe(.value) { snapshot in
            if snapshot.exists() {
                self.game.refreshGame(dataSnapshot: snapshot)
                self.collectionView.reloadData()
            }
        }
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
        if isCellInValidMoves(indexPath) {
            cell.highlightCell()
        }

        // Selected Index
        if let selectedIndex = selectedIndexPath, selectedIndex.item == indexPath.item, selectedIndex.section == indexPath.section {
            cell.highlightPiece()
        }

        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if game.canPlayerSelectCell(row: indexPath.item, col: indexPath.section) {
            selectedIndexPath = indexPath
            validMoves = game.getPossibleMovesForPiece(row: indexPath.item, col: indexPath.section)
            collectionView.reloadData()
        } else if isCellInValidMoves(indexPath) {
            game.movePiece(fromRow: (selectedIndexPath?.item)!, fromCol: (selectedIndexPath?.section)!, toRow: indexPath.item, toCol: indexPath.section)
            validMoves = [IndexPath]()
            game.togglePlayersTurn()
            collectionView.reloadData()
        }
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
