//
//  UserTableViewCell.swift
//  Book Club
//
//  Created by Nick Brenner on 2/2/23.
//

import Foundation
import UIKit

class UserTableViewCell: UITableViewCell {
    var nameLabel = UILabel()
    var userLabel = UILabel()
    var userImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemCyan
        
        nameLabel.textColor = .systemGray6
        nameLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        nameLabel.layer.shadowOffset = CGSize(width: 3, height: 3)
        nameLabel.layer.shadowOpacity = 0.4
        nameLabel.layer.shadowRadius = 2
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        userLabel.textColor = .systemGray6
        userLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        userLabel.layer.shadowOffset = CGSize(width: 3, height: 3)
        userLabel.layer.shadowOpacity = 0.4
        userLabel.layer.shadowRadius = 2
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(userLabel)
        
        userImage.image = UIImage(named: "user_icon")
        userImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(userImage)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            userLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            userImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            userImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            userImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3)
        ])
    }
    
    func configure(user: User) {
        nameLabel.text = user.name
        userLabel.text = user.username
    }
    
}
