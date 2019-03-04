//
//  MenuAlertView.swift
//  Checkers
//
//  Created by Satish Boggarapu on 3/3/19.
//  Copyright © 2019 SatishBoggarapu. All rights reserved.
//

import UIKit
import SnapKit

protocol MenuAlertViewDelegate: class {
    func ruleButtonAction()
    func quitGameButtonAction()
}

class MenuAlertView: UIViewController {
    
    // MARK: UIElements
    private var backgroundView: UIView!
    private var alertView: UIView!
    private var rulesButton: UIButton!
    private var quitGameButton: UIButton!
    
    weak var delegate: MenuAlertViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addConstraints()
        
        // tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        backgroundView.addGestureRecognizer(tapGesture)
        
    }
    
    private func addConstraints() {
        backgroundView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        alertView.snp.makeConstraints { maker in
            maker.left.right.equalToSuperview()
            maker.bottom.equalToSuperview()
            maker.height.equalTo(200)
        }
        
        rulesButton.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(16)
            maker.right.equalToSuperview().inset(16)
            maker.top.equalToSuperview().offset(16)
            maker.height.equalTo(48)
        }
        
        quitGameButton.snp.makeConstraints { maker in
            maker.left.equalToSuperview().offset(16)
            maker.right.equalToSuperview().inset(16)
            maker.top.equalTo(rulesButton.snp.bottom).offset(16)
            maker.height.equalTo(48)
        }
    }
    
    private func setupView() {
        backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.4)
        view.addSubview(backgroundView)
        
        alertView = UIView()
        alertView.backgroundColor = UIColor.boardDark
        alertView.addShadow(offset: .zero, opacity: 0.25, shadowRadius: 5)
        view.insertSubview(alertView, aboveSubview: backgroundView)
        
        rulesButton = UIButton()
        rulesButton.backgroundColor = .highlightColor
        rulesButton.setTitle("Rules", for: .normal)
        rulesButton.setTitleColor(.white, for: .normal)
        rulesButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        rulesButton.addShadow()
        rulesButton.addTarget(self, action: #selector(rulesButtonAction), for: .touchUpInside)
        alertView.addSubview(rulesButton)
        
        quitGameButton = UIButton()
        quitGameButton.backgroundColor = .highlightColor
        quitGameButton.setTitle("Quit Game", for: .normal)
        quitGameButton.setTitleColor(.white, for: .normal)
        quitGameButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        quitGameButton.addShadow()
        quitGameButton.addTarget(self, action: #selector(quitGameButtonAction), for: .touchUpInside)
        alertView.addSubview(quitGameButton)
    }
    
    @objc func dismissView() {
        self.dismiss(animated: false)
    }
    
    @objc private func rulesButtonAction() {
        dismissView()
        delegate?.ruleButtonAction()
    }

    @objc private func quitGameButtonAction() {
        dismissView()
        delegate?.quitGameButtonAction()
    }
    
}
