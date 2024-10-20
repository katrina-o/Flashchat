//
//  MessageCell.swift
//  Flashchat
//
//  Created by Катя on 31.07.2024.
//

import UIKit

class MessageCell: UITableViewCell {
    
    
     static let identifire = "Custom Cell"
    
     var messageView: UIView = {
        let view = UIView()
         view.backgroundColor = .brandPurple
         view.layer.cornerRadius = 23
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
//        messageView.layer.cornerRadius = messageView.frame.size.height / 5
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(/*with view: UIView, */ messageLabel: String, rightImage:UIImage,  and leftImage: UIImage) {
        self.messageLabel.text = messageLabel
        self.rightImage.image = rightImage
        self.leftImage.image = leftImage
    }
    
    func setupUI() {
        self.contentView.addSubview(leftImage)
        self.contentView.addSubview(messageView)
        messageView.addSubview(messageLabel)
        self.contentView.addSubview(rightImage)
    }
    
}
