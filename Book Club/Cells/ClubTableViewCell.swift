//
//  ClubTableViewCell.swift
//  Book Club
//
//  Created by Nick Brenner on 1/30/23.
//

import Foundation
import UIKit

class ClubTableViewCell: UITableViewCell {
    
    var clubName = UILabel()
    var bookStack = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemCyan
        
        clubName.textColor = .systemGray6
        clubName.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        clubName.layer.shadowOffset = CGSize(width: 3, height: 3)
        clubName.layer.shadowOpacity = 0.4
        clubName.layer.shadowRadius = 2
        clubName.translatesAutoresizingMaskIntoConstraints = false
        clubName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(clubName)
        
        bookStack.image = UIImage(named: "book_stack_icon")
        bookStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bookStack)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            clubName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            clubName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bookStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            bookStack.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            bookStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bookStack.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2)
        ])
    }
    
    func configure(club: BookClub) {
        clubName.text = club.name
    }
                                                                               
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
