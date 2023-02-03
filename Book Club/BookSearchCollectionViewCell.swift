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
    var bookTitle = UILabel()
    var author = UILabel()
    var pageCount = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        
        bookCover.contentMode = .scaleAspectFit
        bookCover.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bookCover)
        
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bookTitle)
        
        author.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(author)
        pageCount.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pageCount)
        
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
//            bookTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            bookTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bookTitle.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            author.topAnchor.constraint(equalTo: bookTitle.bottomAnchor, constant: 10),
//            author.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            author.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            author.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            pageCount.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 10),
//            author.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            author.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pageCount.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configure(book: VolumeInfo) {
        bookCover.loadFrom(URLAddress: book.imageLinks.thumbnail)
        bookTitle.text = book.title
        var authorString = "By:"
        for author in book.authors {
            authorString.append(" " + author)
        }
        author.text = authorString
        pageCount.text = "Pages: " + String(book.pageCount)
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
                }
            }
        }
    }
}


