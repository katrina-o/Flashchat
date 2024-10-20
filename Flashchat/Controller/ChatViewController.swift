//
//  ChatViewController.swift
//  Flashchat
//
//  Created by Катя on 31.07.2024.
//

import UIKit
import Firebase
import FirebaseAuth

class ChatViewController: UIViewController, UITableViewDataSource {

    let db = Firestore.firestore()
    var messages:[Message] = []
    
    let sendMessageStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    var messageTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.register(MessageCell.self, forCellReuseIdentifier: MessageCell.identifire)
        return tableView
    }()
    
    var messageTextField = {
        let textField = UITextField()
        textField.placeholder = "write a message"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane.circle.fill"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.appName
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "logOut", style: .plain, target: self, action: #selector(logOutPressed))
        initialize()
        messageTableView.dataSource = self
        loadMessages()
    }
    
    func loadMessages() {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            
            self.messages = []
            
            if let e = error {
                print("There was an issue retrieving data from Firestore. \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.messageTableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.messageTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                } else {
                    print("Successfully saved data.")
                    
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                }
            }
        }
    }
    
    @objc func logOutPressed(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    //MARK: UITableViewDataSourse
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.identifire, for: indexPath) as! MessageCell
        cell.messageLabel.text = message.body
        
        //This is a message from the current user.
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImage.isHidden = true
            cell.rightImage.isHidden = false
            cell.messageView.backgroundColor = UIColor(named:"BrandLightPurple")
            cell.messageLabel.textColor = UIColor(named:"BrandPurple")
        }
        //This is a message from another sender.
        else {
            cell.leftImage.isHidden = false
            cell.rightImage.isHidden = true
            cell.messageView.backgroundColor = UIColor(named:"BrandPurple")
            cell.messageLabel.textColor = UIColor(named:"BrandLightPurple")
        }
        return cell
    }
    
    func initialize() {
        view.backgroundColor = .brandPurple
        view.addSubview(messageTableView)
        view.addSubview(sendMessageStackView)
        sendMessageStackView.addArrangedSubview(messageTextField)
        sendMessageStackView.addArrangedSubview(sendButton)
        
        messageTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
//            make.bottom.equalTo(sendMessageStackView.snp.top)
        }
        sendMessageStackView.snp.makeConstraints { make in
            make.top.equalTo(messageTableView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        sendButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
    }
}
