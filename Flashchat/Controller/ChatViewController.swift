//
//  ChatViewController.swift
//  Flashchat
//
//  Created by Катя on 31.07.2024.
//

import UIKit
import Firebase
import FirebaseAuth


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var messages:[Message] = [
        Message(sender: "1@fg.com", body: "Hi!"),
        Message(sender: "1@fg.com", body: "How are you?")
    ]
    
    var messageTableView: UITableView = {
        let tableView = UITableView()
        tableView.autoresizingMask = .flexibleHeight
        tableView.autoresizingMask = .flexibleWidth
        return tableView
    }()
    
    var messageTextField = {
        let textField = UITextField()
        return textField
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTable()
        initialize()
    }
    
    func createTable() {
        self.messageTableView = UITableView(frame: view.bounds, style: .plain)
        messageTableView.register(MessageCell.self, forCellReuseIdentifier: MessageCell.identifire)
        self.messageTableView.delegate = self
        self.messageTableView.dataSource = self
    }
    
    @objc func sendPressed(_ sender: UIButton) {
        
    }
    
    @objc func logOutPressed(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.identifire, for: indexPath) as? MessageCell else {
            fatalError("The TableView could not dequeue a ArtistCell in ViewController")
        }
        
    }
        
        //MARK: UITableViewDelegate
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            80
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            <#code#>
        }
        
        
        
        func initialize() {
            view.backgroundColor = .brandPurple
            view.addSubview(messageTableView)
            messageTableView.backgroundColor = .white
            
            messageTableView.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide)
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }
            
        }
    }
