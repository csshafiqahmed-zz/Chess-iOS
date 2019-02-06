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
        view.addSubview(textField)

    }
}
