//
//  SingleBookView.swift
//  Testing
//
//  Created by Nick Brenner on 1/28/23.
//

import Foundation
import UIKit

class SingleBookView: UIViewController {
    
    var addingBook = false
    var book: Book
    var bookCover = UIImageView()
    var bookTitle = UITextView()
    var author = UILabel()
    var pageCount = UILabel()
    var addBook = UIButton()
    
    init(book: Book, addingBook: Bool) {
        self.book = book
        self.addingBook = addingBook
        bookCover.loadFrom(URLAddress: book.thumbnail)
        bookTitle.text = book.title
        author.text = "By: " + book.author
        pageCount.text = "Pages: " + String(book.pageCount)
        
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemCyan
        
        bookCover.contentMode = .scaleAspectFit
        bookCover.layer.cornerRadius = 5
        bookCover.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bookCover)
        
        bookTitle.textColor = .white
        bookTitle.textAlignment = .center
        bookTitle.backgroundColor = .systemCyan
        bookTitle.isEditable = false
        bookTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        bookTitle.layer.shadowOffset = CGSize(width: 3, height: 3)
        bookTitle.layer.shadowOpacity = 0.4
        bookTitle.layer.shadowRadius = 2
        bookTitle.contentMode = .scaleAspectFit
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bookTitle)
        
        author.textColor = .white
        author.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        author.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(author)
        
        pageCount.textColor = .white
        pageCount.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        pageCount.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageCount)
        
        if (addingBook) {
            addBook.isHidden = false
        }
        else {
            addBook.isHidden = true
        }
        addBook.backgroundColor = .systemBlue
        addBook.layer.cornerRadius = 8
        addBook.setTitle("Add To Club", for: .normal)
        addBook.titleLabel!.textColor = .white
        addBook.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        addBook.addTarget(self, action: #selector(addBookFunc), for: .touchUpInside)
        addBook.contentMode = .scaleAspectFit
        addBook.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addBook)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            bookCover.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bookCover.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            bookCover.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            bookCover.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bookTitle.topAnchor.constraint(equalTo: bookCover.bottomAnchor, constant: 10),
            bookTitle.leadingAnchor.constraint(equalTo: bookCover.leadingAnchor, constant: -10),
            bookTitle.trailingAnchor.constraint(equalTo: bookCover.trailingAnchor, constant: 10),
            bookTitle.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1)
        ])
        
        NSLayoutConstraint.activate([
            author.topAnchor.constraint(equalTo: bookTitle.bottomAnchor, constant: 2),
            author.centerXAnchor.constraint(equalTo: bookCover.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pageCount.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 10),
            pageCount.centerXAnchor.constraint(equalTo: bookCover.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            addBook.topAnchor.constraint(equalTo: pageCount.bottomAnchor, constant: 60),
            addBook.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.075),
            addBook.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            addBook.centerXAnchor.constraint(equalTo: bookCover.centerXAnchor)
        ])
    }
    
    @objc func addBookFunc() {
        present(MyClubsViewController(selectUser: false, selectUserDelegate: nil, selectUserID: nil, addBook: true, addBookDelegate: self), animated: true, completion: nil)
    }
}

extension SingleBookView: AddBookDelegate {
    func addBook(club: BookClub) {
        print(book.title)
        NetworkManager.createBook(title: book.title, author: book.author, publishedDate: book.publishedDate, pageCount: book.pageCount, smallThumbnail: book.smallThumbnail, thumbnail: book.thumbnail) { response1 in
            print("reached")
            NetworkManager.addBookToClub(bookclub_id: club.id, book_id: response1.id) { response2 in
            }
        }
    }
}

