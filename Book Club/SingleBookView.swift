//
//  SingleBookView.swift
//  Testing
//
//  Created by Nick Brenner on 1/28/23.
//

import Foundation
import UIKit

class SingleBookView: UIViewController {
    
    var book: Book
    var bookCover = UIImageView()
    var bookTitle = UILabel()
    var author = UILabel()
    var pageCount = UILabel()
    var textInfo = UITextView()
    var addBook = UIButton()
    
    init(book: Book) {
        self.book = book
        bookCover.loadFrom(URLAddress: book.thumbnail)
        bookTitle.text = book.title
        author.text = book.author
        pageCount.text = "Pages: " + String(book.pageCount)
        textInfo.text = book.textSnippet
        
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        bookCover.contentMode = .scaleAspectFit
        bookCover.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bookCover)
        
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bookTitle)
        
        author.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(author)
        
        pageCount.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageCount)
        
        textInfo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textInfo)
        
        addBook.setTitle("Add To Club", for: .normal)
        addBook.addTarget(self, action: #selector(addBookFunc), for: .touchUpInside)
        addBook.backgroundColor = .blue
        addBook.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addBook)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            bookCover.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bookCover.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            bookCover.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            bookCover.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            bookTitle.topAnchor.constraint(equalTo: bookCover.bottomAnchor, constant: 20),
            bookTitle.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            author.topAnchor.constraint(equalTo: bookTitle.bottomAnchor, constant: 10),
            author.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            pageCount.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 10),
            pageCount.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            addBook.topAnchor.constraint(equalTo: pageCount.bottomAnchor, constant: 10),
            addBook.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc func addBookFunc() {
        present(MyClubsViewController(addBook: true, addBookDelegate: self), animated: true, completion: nil)
    }
}

extension SingleBookView: AddBookDelegate {
    func addBook(club: BookClub) {
        NetworkManager.addBookToClub(bookclub_id: club.id, book_id: book.id) { response in
        }
    }
}

