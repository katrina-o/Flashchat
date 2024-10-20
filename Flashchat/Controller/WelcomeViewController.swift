//
//  ViewController.swift
//  Flashchat
//
//  Created by Катя on 31.07.2024.
//

import UIKit
import CLTypingLabel
import SnapKit

class WelcomeViewController: UIViewController {

    var titleLabel: CLTypingLabel = {
        let label = CLTypingLabel()
        // command+control+space=emodgi
        label.text = "⚡️FlashChat"
        label.textColor = .brandBlue
        label.font = UIFont.boldSystemFont(ofSize: 50)
        return label
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.brandBlue, for: .normal)
        button.backgroundColor = .brandLightBlue
        button.addTarget(self, action: #selector(pressRegisterButton), for: .touchUpInside)
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .brandBlue
        button.addTarget(self, action: #selector(pressLoginButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
//        titleLabel.text = ""
//        var charIndex = 0.0
//        let titleText = "⚡️FlashChat"
//        for letter in titleText {
//            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
//                self.titleLabel.text?.append(letter)
//            }
//            charIndex += 1
//        }
    }

    @objc func pressRegisterButton( _ sender: UIButton) {
        let rvc = RegisterViewController()
        navigationController?.pushViewController(rvc, animated: true)
    }
    
    @objc func pressLoginButton( _ sender: UIButton) {
        let lvc = LoginViewController()
        navigationController?.pushViewController(lvc, animated: true)
    }
    
    func initialize() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(registerButton)
        view.addSubview(loginButton)

        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
 
        registerButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalTo(loginButton).inset(40)
        }
        
        loginButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
}

