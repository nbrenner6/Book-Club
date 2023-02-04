//
//  BookSearchCollectionViewCell.swift
//  Testing
//
//  Created by Nick Brenner on 1/28/23.
//

import Foundation
import UIKit

class BookSearchCollectionViewCell: UICollectionViewCell {
    var bookCover = UIImageView()
    var bookTitle = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemCyan
        
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        
        bookCover.layer.cornerRadius = 5
        bookCover.contentMode = .scaleAspectFit
        bookCover.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bookCover)
        
        bookTitle.textColor = .black
        bookTitle.backgroundColor = .systemCyan
        bookTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        bookTitle.isEditable = false
        bookTitle.textAlignment = .center
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
            bookCover.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            bookCover.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7)
        ])
        
        NSLayoutConstraint.activate([
            bookTitle.topAnchor.constraint(equalTo: bookCover.bottomAnchor, constant: -5),
            bookTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            bookTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            bookTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5)
        ])
    }
    
    func configure(book: Book) {
        bookCover.loadFrom(URLAddress: book.thumbnail)
        bookTitle.text = book.title
    }
}

extension UIImageView {
    func changeLink(link: String) -> String {
        return link.replacingOccurrences(of: "http", with: "https")
    }
    
    func loadFrom(URLAddress: String) {
        let httpsURL = changeLink(link: URLAddress)
        guard let url = URL(string: httpsURL) else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self?.image = loadedImage
                    self?.layer.cornerRadius = 5
                }
            }
        }
    }
}


