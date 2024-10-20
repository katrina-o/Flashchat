//
//  LoginViewController.swift
//  Flashchat
//
//  Created by Катя on 31.07.2024.
//

import UIKit
import SnapKit
import FirebaseAuth

class LoginViewController: UIViewController {
   
    let loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 25
        textField.placeholder = "Email"
        textField.textAlignment = .center
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 25
        textField.placeholder =  "Password"
        textField.textAlignment = .center
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.contentMode = .center
        button.addTarget(self, action: #selector(pressLoginButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    @objc func pressLoginButton( _ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let self = self else { return }
                if let e = error {
                    print(e)
                } else {
                    let cvc = ChatViewController()
                    self.navigationController?.pushViewController(cvc, animated: true)
                }
            }
        }
    }
    
    func initialize() {
        view.backgroundColor = .brandBlue
        view.addSubview(loginStackView)
        loginStackView.addArrangedSubview(emailTextField)
        loginStackView.addArrangedSubview(passwordTextField)
        loginStackView.addArrangedSubview(loginButton)

        loginStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.leading.equalToSuperview().inset(10)  
        }
    }
}
