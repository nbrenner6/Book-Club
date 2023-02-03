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
    var searchResults: Books?
    var collectionView: UICollectionView!
    
    let searchReuseIdentifier: String = "searchReuseIdentifier"
    let spacing: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchText.placeholder = "Book name..."
        searchText.backgroundColor = .white
        searchText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchText)
        
        searchButton.setTitle("Search", for: .normal)
        searchButton.backgroundColor = .blue
        searchButton.addTarget(self, action: #selector(searchForBook), for: .touchUpInside)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchText.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            searchText.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            searchText.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            searchButton.leadingAnchor.constraint(equalTo: searchText.trailingAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupCollectionViewConstraints() {
        let collectionViewPadding: CGFloat = 12
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchText.bottomAnchor, constant: collectionViewPadding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
            collectionView.heightAnchor.constraint(equalToConstant: 200),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding)
        ])
    }
    
    @objc func searchForBook() {
//        let group = DispatchGroup()
//        group.enter()
//        DispatchQueue.global(qos: .default).async {
//        }
//        CATransaction.begin()
        print("REACHED1")
        NetworkManager.search(keyword: self.searchText.text ?? "NO TEXT") { response in
            print("REACHED2")
            print("\(response.items.first?.volumeInfo.title)")
            self.searchResults = response
            
            let searchLayout = UICollectionViewFlowLayout()
            searchLayout.minimumLineSpacing = self.spacing
            searchLayout.minimumInteritemSpacing = self.spacing
            searchLayout.scrollDirection = .horizontal
            
            if (self.collectionView == nil) {
                print("REACHED3")
                self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: searchLayout)
                self.collectionView.register(BookSearchCollectionViewCell.self, forCellWithReuseIdentifier: self.searchReuseIdentifier)
                self.collectionView.dataSource = self
                self.collectionView.delegate = self
                self.collectionView.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(self.collectionView)
            
                self.setupCollectionViewConstraints()
            }
            else {
                print("REACHED4")
                self.collectionView.reloadData()
            }
        }
//        CATransaction.setCompletionBlock {
//            // this runs after reloadData is done
//            let searchLayout = UICollectionViewFlowLayout()
//            searchLayout.minimumLineSpacing = self.spacing
//            searchLayout.minimumInteritemSpacing = self.spacing
//            searchLayout.scrollDirection = .horizontal
//
//            if (self.collectionView == nil) {
//                print("REACHED")
//                self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: searchLayout)
//                self.collectionView.register(BookSearchCollectionViewCell.self, forCellWithReuseIdentifier: self.searchReuseIdentifier)
//                self.collectionView.dataSource = self
//                self.collectionView.delegate = self
//                self.collectionView.translatesAutoresizingMaskIntoConstraints = false
//                self.view.addSubview(self.collectionView)
//
//                self.setupCollectionViewConstraints()
//            }
//            else {
//                print("REACHED2")
//                self.collectionView.reloadData()
//            }
//        }
//        CATransaction.commit()
//        group.wait()
//        self.searchResults = searchResults!
    }
}

extension BookSearchView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("REACHED5")
        return searchResults!.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchReuseIdentifier, for: indexPath) as? BookSearchCollectionViewCell {
            cell.configure(book: (searchResults?.items[indexPath.row].volumeInfo)!)
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
}

extension BookSearchView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 10) / 3.0
        let height = (collectionView.frame.height - 10)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
     didSelectItemAt indexPath: IndexPath) {
        var volume = searchResults?.items[indexPath.row].volumeInfo
        var searchInfo = searchResults?.items[indexPath.row].searchInfo
        NetworkManager.createBook(title: volume!.title, author: volume!.authors[0], publishedDate: volume!.publishedDate, pageCount: volume!.pageCount, textSnippet: searchInfo!.textSnippet, smallThumbnail: volume!.imageLinks.smallThumbnail, thumbnail: volume!.imageLinks.thumbnail) { response in
            
            self.navigationController?.pushViewController(SingleBookView(book: response), animated: true)
        }
    }
}

