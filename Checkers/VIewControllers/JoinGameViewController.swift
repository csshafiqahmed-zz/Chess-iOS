//
// Created by Satish Boggarapu on 2019-02-05.
// Copyright (c) 2019 SatishBoggarapu. All rights reserved.
//

import UIKit
import SnapKit

class JoinGameViewController: UIViewController {

    // MARK: UIElements
    private var titleLabel: UILabel!
    private var textField: UITextField!
    private var errorLabel: UILabel!

    // MARK: Attributes
    private var firebaseGameController: FirebaseGameController!
    private var game: Game!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .backgroundColor
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.barTintColor = .backgroundColor
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isOpaque = false

        firebaseGameController = FirebaseGameController()
        game = Game.getInstance()

        setupView()
        addConstraints()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            Game.getInstance().setPlayer2Name(nil)
        }
    }

    private func addConstraints() {
        titleLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(32)
            maker.right.equalToSuperview().inset(32)
            maker.top.equalToSuperview().offset(32)
            maker.height.equalTo(titleLabel.intrinsicContentSize.height)
        }

        textField.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(32)
            maker.right.equalToSuperview().inset(32)
            maker.top.equalTo(titleLabel.snp.bottom).offset(82)
            maker.height.equalTo(52)
        }

        errorLabel.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(32)
            maker.right.equalToSuperview().inset(32)
            maker.top.equalTo(textField.snp.bottom).offset(16)
            maker.height.equalTo(errorLabel.intrinsicContentSize.height*2)
        }
    }

    private func setupView() {
        titleLabel = UILabel()
        titleLabel.text = "Join a new game"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        view.addSubview(titleLabel)

        textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Enter the game code",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x9e9e9e)])
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 36, weight: .medium)
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        view.addSubview(textField)

        errorLabel = UILabel()
        errorLabel.text = "Invalid code. Game does not exist or currently in progress"
        errorLabel.textColor = .red
        errorLabel.textAlignment = .center
        errorLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        errorLabel.numberOfLines = 2
        errorLabel.lineBreakMode = .byWordWrapping
        errorLabel.isHidden = true
        view.addSubview(errorLabel)

    }

    @objc private func textFieldDidChange() {
        if textField.text?.count == 6 {
            self.errorLabel.isHidden = true
            textField.isUserInteractionEnabled = false
            textField.resignFirstResponder()
            firebaseGameController.isGameUidValid(textField.text!) { firebaseJoinGameCompletion in
                switch firebaseJoinGameCompletion {
                case .gameWaitingForPlayer2:
                    self.joinGame()
                case .gameInProgress:
                    self.errorLabel.isHidden = false
                    self.textField.isUserInteractionEnabled = true
                }
            }
        }
    }

    private func joinGame() {
        firebaseGameController.pushPlayer2ToFirebase(textField.text!)
        game.setGameUid(textField.text)
        self.navigationController?.pushViewController(BoardViewController(), animated: true)
    }
}
