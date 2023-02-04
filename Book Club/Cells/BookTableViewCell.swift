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
    var bookTitle = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemCyan
        
        bookCover.contentMode = .scaleAspectFit
        bookCover.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bookCover)
        
        bookTitle.textColor = .black
        bookTitle.textAlignment = .center
        bookTitle.backgroundColor = .systemCyan
        bookTitle.isEditable = false
        bookTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        bookTitle.layer.shadowOffset = CGSize(width: 3, height: 3)
        bookTitle.layer.shadowOpacity = 0.4
        bookTitle.layer.shadowRadius = 2
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bookTitle)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            bookCover.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            bookCover.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            bookCover.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            bookCover.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3)
        ])
        
        NSLayoutConstraint.activate([
            bookTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            bookTitle.leadingAnchor.constraint(equalTo: bookCover.trailingAnchor, constant: 20),
            bookTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            bookTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    func configure(book: Book) {
        bookCover.loadFrom(URLAddress: book.thumbnail)
        bookTitle.text = book.title
    }
}
