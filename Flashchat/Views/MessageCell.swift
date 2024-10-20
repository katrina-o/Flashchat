//
//  MessageCell.swift
//  Flashchat
//
//  Created by Катя on 31.07.2024.
//

import UIKit
import SnapKit

class MessageCell: UITableViewCell {
    
     static let identifire = "Custom Cell"
    
    let messageStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
     var messageView: UIView = {
        let view = UIView()
         view.backgroundColor = .brandPurple
         view.layer.cornerRadius = 18
        return view
    }()
    
     var messageLabel: UILabel = {
        let label = UILabel()
         label.text = "Hello"
         label.textColor = .white
         label.font = UIFont.systemFont(ofSize: 20)
         label.numberOfLines = 0
         label.textAlignment = .left
        return label
    }()
    
     var rightImage: UIImageView = {
        let image = UIImageView()
         image.image = UIImage(named: "MeAvatar")
         image.contentMode = .right
        return image
    }()
    
    var leftImage: UIImageView = {
        let image = UIImageView()
         image.image = UIImage(named: "YouAvatar")
        image.contentMode = .left
        return image
   }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(/*with view: UIView, */ messageLabel: String, rightImage:UIImage,  and leftImage: UIImage) {
        DispatchQueue.main.async {
            self.messageLabel.text = messageLabel
            self.rightImage.image = rightImage
            self.leftImage.image = leftImage
        }
    }
    
    func setupUI() {
        addSubview(messageStackView)
        messageStackView.addArrangedSubview(leftImage)
        messageStackView.addArrangedSubview(messageView)
        messageStackView.addArrangedSubview(rightImage)
        messageView.addSubview(messageLabel)
        
        messageStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        leftImage.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        rightImage.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }    
}
