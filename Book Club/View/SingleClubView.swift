//
//  SingleClubView.swift
//  Book Club
//
//  Created by Nick Brenner on 1/30/23.
//

import Foundation
import UIKit

class SingleClubView: UIViewController {
    
    var joinClub = false
    var club: BookClub
    var clubName = UILabel()
    var joinButton = UIButton()
    var graphic = UIImageView()
    var clubBooks = UITableView()
    var clubBooksReuseIdentifier = "booksReuseIdentifier"
    
    init(club: BookClub, joinClub: Bool) {
        self.club = club
        self.joinClub = joinClub
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemCyan
        
        clubName.textColor = .white
        clubName.text = club.name
        clubName.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        clubName.layer.shadowOffset = CGSize(width: 3, height: 3)
        clubName.layer.shadowOpacity = 0.4
        clubName.layer.shadowRadius = 2
        clubName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(clubName)
        
        clubBooks.backgroundColor = .systemCyan
        clubBooks.dataSource = self
        clubBooks.delegate = self
        clubBooks.register(BookTableViewCell.self, forCellReuseIdentifier: clubBooksReuseIdentifier)
        clubBooks.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(clubBooks)
        
        if (joinClub) {
            joinButton.isHidden = false
        }
        else {
            joinButton.isHidden = true
        }
        joinButton.backgroundColor = .systemBlue
        joinButton.layer.cornerRadius = 8
        joinButton.setTitle("Join Club", for: .normal)
        joinButton.titleLabel!.textColor = .white
        joinButton.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        joinButton.addTarget(self, action: #selector(joinFunc), for: .touchUpInside)
        joinButton.contentMode = .scaleAspectFit
        joinButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(joinButton)
        
        graphic.contentMode = .scaleAspectFit
        graphic.image = UIImage(named: "club_icon")
        graphic.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(graphic)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            clubName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            clubName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            clubBooks.topAnchor.constraint(equalTo: clubName.bottomAnchor, constant: 5),
            clubBooks.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            clubBooks.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            clubBooks.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            joinButton.topAnchor.constraint(equalTo: clubBooks.bottomAnchor, constant: 10),
            joinButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.075),
            joinButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            joinButton.centerXAnchor.constraint(equalTo: clubName.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            graphic.topAnchor.constraint(equalTo: joinButton.bottomAnchor, constant: 5),
            graphic.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            graphic.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            graphic.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func joinFunc() {
        NetworkManager.addUserToClub(bookclub_id: club.id, user_id: UserID.user_id) { response in
            self.navigationController?.popViewController(animated: true)
        }
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(SingleBookView(book: club.books[indexPath.row], addingBook: false), animated: true)
    }
}
