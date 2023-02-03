//
//  SingleClubView.swift
//  Book Club
//
//  Created by Nick Brenner on 1/30/23.
//

import Foundation
import UIKit

class SingleClubView: UIViewController {
    
    var club: BookClub
    var clubName = UILabel()
    var clubBooks = UITableView()
    var clubBooksReuseIdentifier = "booksReuseIdentifier"
    
    init(club: BookClub) {
        self.club = club
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clubName.text = club.name
        clubName.textColor = .white
        clubName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(clubName)
        
        clubBooks.dataSource = self
        clubBooks.delegate = self
        clubBooks.register(BookTableViewCell.self, forCellReuseIdentifier: clubBooksReuseIdentifier)
        clubBooks.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(clubBooks)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            clubName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            clubName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            clubBooks.topAnchor.constraint(equalTo: clubName.bottomAnchor, constant: 20),
            clubBooks.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            clubBooks.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            clubBooks.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    

}

extension SingleClubView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return club.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = clubBooks.dequeueReusableCell(withIdentifier: clubBooksReuseIdentifier, for: indexPath) as? BookTableViewCell {
            cell.configure(book: club.books[indexPath.row])
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
}

extension SingleClubView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(SingleBookView(book: club.books[indexPath.row]), animated: true)
    }
}
