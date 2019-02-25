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
    private var nameTextField: UITextField!
    private var nameErrorLabel: UILabel!

    // MARK: Attributes
    private var game: Game!
    private var firebaseGameController: FirebaseGameController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = .backgroundColor
        game = Game.getInstance()
        firebaseGameController = FirebaseGameController()
        
        setupView()
        addConstraints()
        textFieldDidChange()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        tap.numberOfTouchesRequired = 1
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func addConstraints() {
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
        
        nameTextField.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(32)
            maker.right.equalToSuperview().inset(32)
            maker.top.equalTo(versionLabel.snp.bottom).offset(54)
            maker.height.equalTo(52)
        }

        nameErrorLabel.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview()
            maker.top.equalTo(nameTextField.snp.bottom).offset(16)
            maker.height.equalTo(nameErrorLabel.intrinsicContentSize.height)
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
        
        nameTextField = UITextField()
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Enter your name",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x9e9e9e)])
        nameTextField.textColor = .white
        nameTextField.font = UIFont.systemFont(ofSize: 36, weight: .medium)
        nameTextField.textAlignment = .center
        nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        view.addSubview(nameTextField)
        
        startGameButton = UIButton()
        startGameButton.backgroundColor = .highlightColor
        startGameButton.setTitle("Start Game", for: .normal)
        startGameButton.setTitleColor(.white, for: .normal)
        startGameButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        startGameButton.addShadow()
        startGameButton.addTarget(self, action: #selector(startGameButtonAction), for: .touchUpInside)
        view.addSubview(startGameButton)
        
        joinGameButton = UIButton()
        joinGameButton.backgroundColor = .highlightColor
        joinGameButton.setTitle("Join Game", for: .normal)
        joinGameButton.setTitleColor(.white, for: .normal)
        joinGameButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        joinGameButton.addShadow()
        joinGameButton.addTarget(self, action: #selector(joinGameButtonAction), for: .touchUpInside)
        view.addSubview(joinGameButton)

        nameErrorLabel = UILabel()
        nameErrorLabel.text = "Name should be greater then 1 letter"
        nameErrorLabel.textColor = .red
        nameErrorLabel.textAlignment = .center
        nameErrorLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        nameErrorLabel.numberOfLines = 2
        nameErrorLabel.lineBreakMode = .byWordWrapping
        nameErrorLabel.isHidden = true
        view.addSubview(nameErrorLabel)
    }
    
    @objc private func startGameButtonAction() {
        // Set Player1 name
        game.startNewGame(nameTextField.text!)
        game.setIsPlayer1(true)
        // Create game in firebase
        firebaseGameController.createNewGame()
        navigationController?.pushViewController(StartNewGameViewController(), animated: true)
    }
    
    @objc private func joinGameButtonAction() {
        game.setPlayer2Name(nameTextField.text!)
        game.setIsPlayer1(false)
        navigationController?.pushViewController(JoinGameViewController(), animated: true)
    }

    @objc private func textFieldDidChange() {
        startGameButton.isEnabled = (nameTextField.text?.count)! > 1
        joinGameButton.isEnabled = (nameTextField.text?.count)! > 1
        nameErrorLabel.isHidden = (nameTextField.text?.count)! > 1
        startGameButton.backgroundColor = (startGameButton.isEnabled) ? .highlightColor : .buttonDisabled
        joinGameButton.backgroundColor = (joinGameButton.isEnabled) ? .highlightColor : .buttonDisabled
    }

    @objc private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

