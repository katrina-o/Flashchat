//
//  RegisterViewController.swift
//  Flashchat
//
//  Created by Катя on 31.07.2024.
//

import UIKit
import SnapKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
// ...
      
class RegisterViewController: UIViewController {
    
    let registerStackView: UIStackView = {
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
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.brandBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.contentMode = .center
        button.addTarget(self, action: #selector(pressRegisterButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    @objc func pressRegisterButton( _ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    let cvc = ChatViewController()
                    self.navigationController?.pushViewController(cvc, animated: true)
                }
            }
        }
    }
    
    func initialize() {
        view.backgroundColor = .brandLightBlue
        view.addSubview(registerStackView)
        registerStackView.addArrangedSubview(emailTextField)
        registerStackView.addArrangedSubview(passwordTextField)
        registerStackView.addArrangedSubview(registerButton)

        registerStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.leading.equalToSuperview().inset(10)
        }
    }
}
