//
//  BookTableViewCell.swift
//  Book Club
//
//  Created by Nick Brenner on 1/30/23.
//

import Foundation
import UIKit

class BookTableViewCell: UITableViewCell {
    var bookCover = UIImageView()
    var bookTitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        
        bookCover.contentMode = .scaleAspectFit
        bookCover.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bookCover)
        
        bookTitle.textColor = .black
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bookTitle)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            bookCover.topAnchor.constraint(equalTo: contentView.topAnchor),
            bookCover.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bookCover.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bookCover.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            bookTitle.topAnchor.constraint(equalTo: bookCover.bottomAnchor, constant: 20),
            bookTitle.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configure(book: Book) {
        bookCover.loadFrom(URLAddress: book.thumbnail)
        bookTitle.text = book.title
    }
}
