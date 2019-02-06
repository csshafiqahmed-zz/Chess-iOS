//
// Created by Satish Boggarapu on 2019-02-05.
// Copyright (c) 2019 SatishBoggarapu. All rights reserved.
//

import UIKit
import SnapKit

class BoardViewController: UIViewController {

    // MARK: UIElements
    private var collectionView: UICollectionView!
    private var player1ImageView: UIImageView!
    private var player1Label: UILabel!
    private var player1CounterLabel: UILabel!
    private var player2ImageView: UIImageView!
    private var player2Label: UILabel!
    private var player2CounterLabel: UILabel!

    // MARK: Attributes
    private let boardSize = UIScreen.main.bounds.width - 24

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .backgroundColor
        navigationController?.setNavigationBarHidden(true, animated: false)

        setupView()
        addConstraints()
    }

    private func addConstraints() {


        collectionView.snp.makeConstraints { maker in
            maker.centerX.centerY.equalToSuperview()
            maker.size.equalTo(boardSize)
        }

    }

    private func setupView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)

        
    }
}

extension BoardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

        let sum = indexPath.section + indexPath.item
        if sum % 2 == 0 {
            cell.backgroundColor = UIColor(hex: 0x009688)
        } else {
            cell.backgroundColor = UIColor(hex: 0xE0E0E0)
        }

        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = boardSize/10.0
        return CGSize(width: cellSize, height: cellSize)
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
