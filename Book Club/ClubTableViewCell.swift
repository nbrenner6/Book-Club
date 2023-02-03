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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        clubName.textColor = .black
        clubName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(clubName)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            clubName.topAnchor.constraint(equalTo: contentView.topAnchor),
            clubName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func configure(club: BookClub) {
        clubName.text = club.name
    }
                                                                               
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
