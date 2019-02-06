//
//  StartNewGameViewController.swift
//  Checkers
//
//  Created by Satish Boggarapu on 2/5/19.
//  Copyright © 2019 SatishBoggarapu. All rights reserved.
//

import UIKit
import SnapKit

class StartNewGameViewController: UIViewController {

    // MARK: UIElements
    private var headerLabel: UILabel!
    private var gameUidLabel: UILabel!
    private var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .backgroundColor
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.barTintColor = .backgroundColor
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isOpaque = false
        
        setupView()
        addConstraints()
    }
    
    private func addConstraints() {
        headerLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(32)
            maker.right.equalToSuperview().inset(32)
            maker.top.equalToSuperview().offset(32)
            maker.height.equalTo(164)
        }

        gameUidLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(32)
            maker.right.equalToSuperview().inset(32)
            maker.top.equalTo(self.view.snp.centerY).offset(-50)
            maker.height.equalTo(36)
        }

        descriptionLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(32)
            maker.right.equalToSuperview().inset(32)
            maker.top.equalTo(self.view.snp.bottom).inset(300)
            maker.bottom.equalToSuperview().inset(24)
        }
    }
    
    private func setupView() {
        headerLabel = UILabel()
        headerLabel.text = "New game started. Waiting for player 2 to join..."
        headerLabel.textColor = .white
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        headerLabel.numberOfLines = 0
        headerLabel.lineBreakMode = .byWordWrapping
        view.addSubview(headerLabel)

        gameUidLabel = UILabel()
        gameUidLabel.text = "123456"
        gameUidLabel.textColor = .highlightColor
        gameUidLabel.textAlignment = .center
        gameUidLabel.font = UIFont.systemFont(ofSize: 42, weight: .bold)
        view.addSubview(gameUidLabel)

        descriptionLabel = UILabel()
        descriptionLabel.text = "Share the above code with your opponent to start the game."
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        view.addSubview(descriptionLabel)
    }

}
