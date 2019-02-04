//
//  PictureCell.swift
//  demo
//
//  Created by Jesse on 2019/2/4.
//  Copyright © 2019 Jesse. All rights reserved.
//

import UIKit

class PictureCell: UITableViewCell {
    // Lazy variables for the various elements required to make up our view heirarchy.
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var userInfoStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private lazy var picView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.purple
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add our components to the view heirarchy.
        addComponents()
        
        // Define our autolayout constraints.
        layoutComponents()
        
        // Apply some sample values
        nameLabel.text = "Username"
        moreButton.setTitle("...", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func addComponents() {
        
        userInfoStackView.addArrangedSubview(avatarImageView)
        userInfoStackView.addArrangedSubview(nameLabel)
        userInfoStackView.addArrangedSubview(moreButton)
        
        rootStackView.addArrangedSubview(userInfoStackView)
        rootStackView.addArrangedSubview(picView)
        
        addSubview(rootStackView)
    }
    
    private func layoutComponents() {
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 45),
            moreButton.widthAnchor.constraint(equalToConstant: 45),
            userInfoStackView.heightAnchor.constraint(equalToConstant: 50),
            picView.widthAnchor.constraint(equalTo: widthAnchor),
            picView.leadingAnchor.constraint(equalTo: userInfoStackView.leadingAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rootStackView.topAnchor.constraint(equalTo: topAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
    }
}
