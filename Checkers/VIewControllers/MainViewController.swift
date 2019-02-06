//
//  ViewController.swift
//  Checkers
//
//  Created by Satish Boggarapu on 2/5/19.
//  Copyright © 2019 SatishBoggarapu. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    // MARK: UIElements
    private var titleLabel: UILabel!
    private var versionLabel: UILabel!
    private var startGameButton: UIButton!
    private var joinGameButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = .backgroundColor
        setupView()
        addConstaints()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func addConstaints() {
        titleLabel.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview()
            maker.top.equalToSuperview().offset(150)
            maker.height.equalTo(55)
        }
        
        versionLabel.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview()
            maker.top.equalTo(titleLabel.snp.bottom).offset(8)
            maker.height.equalTo(24)
        }
        
        startGameButton.snp.makeConstraints { maker in
            maker.top.equalTo(self.view.snp.centerY)
            maker.left.equalToSuperview().offset(32)
            maker.right.equalToSuperview().inset(32)
            maker.height.equalTo(52)
        }
        
        joinGameButton.snp.makeConstraints { maker in
            maker.top.equalTo(startGameButton.snp.bottom).offset(36)
            maker.left.equalToSuperview().offset(32)
            maker.right.equalToSuperview().inset(32)
            maker.height.equalTo(52)
        }
    }
    
    private func setupView() {
        titleLabel = UILabel()
        titleLabel.text = "Checkers"
        titleLabel.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        versionLabel = UILabel()
        versionLabel.text = "v1.0"
        versionLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        versionLabel.textColor = .white
        versionLabel.textAlignment = .center
        view.addSubview(versionLabel)
        
        startGameButton = UIButton()
        startGameButton.backgroundColor = .highlightColor
        startGameButton.setTitle("Start Game", for: .normal)
        startGameButton.setTitleColor(.white, for: .normal)
        startGameButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        startGameButton.addShadow()
        view.addSubview(startGameButton)
        
        joinGameButton = UIButton()
        joinGameButton.backgroundColor = .highlightColor
        joinGameButton.setTitle("Join Game", for: .normal)
        joinGameButton.setTitleColor(.white, for: .normal)
        joinGameButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        joinGameButton.addShadow()
        view.addSubview(joinGameButton)
    }


}

