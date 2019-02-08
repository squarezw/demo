//
//  PictureCell.swift
//  demo
//
//  Created by Jesse on 2019/2/4.
//  Copyright © 2019 Jesse. All rights reserved.
//

import UIKit
import SDWebImage
import SkeletonView

class MediaCell: UITableViewCell {
    
    var viewModel: MediaViewModel? = nil {
        didSet {
            guard oldValue?.media != viewModel?.media else { return }
            
            updateUI()
        }
    }
    
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var userInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var picView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.gray, for: .normal)
        button.setTitle("...", for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add our components to the view heirarchy.
        addComponents()
        
        // Define our autolayout constraints.
        layoutComponents()
        
        showLoadingAnimation()
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
    
    private func showLoadingAnimation() {
        isSkeletonable = true
        showAnimatedSkeleton()
    }
    
    private func hideLoadingAnimation() {
        hideSkeleton()
    }
    
    private func layoutComponents() {
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: 45),
            moreButton.widthAnchor.constraint(equalToConstant: 45),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 5),
            userInfoStackView.heightAnchor.constraint(equalToConstant: 50),
            picView.widthAnchor.constraint(equalTo: widthAnchor),
            picView.leadingAnchor.constraint(equalTo: userInfoStackView.leadingAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rootStackView.topAnchor.constraint(equalTo: topAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ])
    }
    
    private func updateUI() {
        guard let viewModel = viewModel else { return }
        
        hideLoadingAnimation()
        
        nameLabel.text = viewModel.username
        avatarImageView.sd_setImage(with: viewModel.avatar)
        picView.sd_setImage(with: viewModel.picture)
    }
}
