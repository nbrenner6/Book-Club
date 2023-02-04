//
//  BookSearchView.swift
//  Testing
//
//  Created by Nick Brenner on 1/28/23.
//

import Foundation
import UIKit

class BookSearchView: UIViewController {
    var searchButton = UIButton()
    var searchText = UITextField()
    var featuredSearchResults: Books?
    var searchResults: Books?
    var collectionView: UICollectionView!
    var tableView = UITableView()
    var reuseIdentifier = "reuseIdentifier"
    
    let searchReuseIdentifier: String = "searchReuseIdentifier"
    let spacing: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        
        searchText.attributedPlaceholder = NSAttributedString(
            string: "Search...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2, NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 20)]
        )
        searchText.backgroundColor = .white
        searchText.textColor = .systemGray2
        searchText.layer.cornerRadius = 5
        searchText.font = UIFont(name: "Helvetica-Bold", size: 20)
        searchText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchText)
        
        searchButton.setTitle("Search", for: .normal)
        searchButton.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        searchButton.backgroundColor = .systemBlue
        searchButton.addTarget(self, action: #selector(searchForBook), for: .touchUpInside)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            searchText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            searchText.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            searchText.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            searchButton.leadingAnchor.constraint(equalTo: searchText.trailingAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupCollectionViewConstraints() {
        let collectionViewPadding: CGFloat = 8
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchText.bottomAnchor, constant: collectionViewPadding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding)
        ])
    }
    
    func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func searchForBook() {
        NetworkManager.search(keyword: self.searchText.text ?? "NO TEXT") { response in
            var featuredBooks: [BookEntry] = []
            var books: [BookEntry] = []
            if (response.items.count == 0) {
                print("here?")
                //No results
            }
            else {
                let endFeaturedIndex = response.items.count / 4
                let startIndex = endFeaturedIndex + 1
                print (response.items.count)
                for i in 0...endFeaturedIndex {
                    featuredBooks.append(response.items[i])
                }
                if (response.items.count > 1) {
                    for i in startIndex...response.items.count - 1 {
                        books.append(response.items[i])
                    }
                }
                let featured = Books(items: featuredBooks)
                let other = Books(items: books)
                
                self.featuredSearchResults = featured
                self.searchResults = other
                
                let searchLayout = UICollectionViewFlowLayout()
                searchLayout.minimumLineSpacing = self.spacing
                searchLayout.minimumInteritemSpacing = self.spacing
                searchLayout.scrollDirection = .horizontal
                
                if (self.collectionView == nil) {
                    self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: searchLayout)
                    self.collectionView.register(BookSearchCollectionViewCell.self, forCellWithReuseIdentifier: self.searchReuseIdentifier)
                    self.collectionView.dataSource = self
                    self.collectionView.delegate = self
                    self.collectionView.layer.cornerRadius = 5
                    self.collectionView.backgroundColor = .systemCyan
                    self.collectionView.translatesAutoresizingMaskIntoConstraints = false
                    self.view.addSubview(self.collectionView)
                    
                    self.setupCollectionViewConstraints()
                }
                else {
                    self.collectionView.reloadData()
                }
                
                if (books.count != 0) {
                    if (self.tableView.dataSource == nil) {
                        self.tableView.backgroundColor = .systemCyan
                        self.tableView.register(BookTableViewCell.self, forCellReuseIdentifier: self.reuseIdentifier)
                        self.tableView.dataSource = self
                        self.tableView.delegate = self
                        self.tableView.translatesAutoresizingMaskIntoConstraints = false
                        self.view.addSubview(self.tableView)
                        
                        self.setupTableViewConstraints()
                    }
                    else {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func configureData(bookEntry: BookEntry) -> Book {
        let volume = bookEntry.volumeInfo
        return Book(id: 0, title: volume.title, author: volume.authors[0], publishedDate: volume.publishedDate, pageCount: volume.pageCount, smallThumbnail: volume.imageLinks.smallThumbnail, thumbnail: volume.imageLinks.thumbnail)
    }
}

extension BookSearchView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featuredSearchResults!.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchReuseIdentifier, for: indexPath) as? BookSearchCollectionViewCell {
            let currentBook = configureData(bookEntry: (featuredSearchResults?.items[indexPath.row])!)
            cell.configure(book: currentBook)
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
}

extension BookSearchView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 10) / 2.5
        let height = (collectionView.frame.height)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
     didSelectItemAt indexPath: IndexPath) {
        let currentBook = configureData(bookEntry: (featuredSearchResults?.items[indexPath.row])!)
        self.navigationController?.pushViewController(SingleBookView(book: currentBook, addingBook: true), animated: true)
    }
}

extension BookSearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults!.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath) as? BookTableViewCell {
            let currentBook = configureData(bookEntry: (searchResults?.items[indexPath.row])!)
            cell.configure(book: currentBook)
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
}

extension BookSearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentBook = configureData(bookEntry: (searchResults?.items[indexPath.row])!)
        self.navigationController?.pushViewController(SingleBookView(book: currentBook, addingBook: true), animated: true)
    }
}

