//
//  MyClubsViewController.swift
//  Book Club
//
//  Created by Nick Brenner on 1/30/23.
//

import Foundation
import UIKit

class MyClubsViewController: UIViewController {
    var clubs: [BookClub]?
    var header = UILabel()
    var clubDisplay = UITableView()
    let clubDisplayReuseIdentifier = "clubDisplayReuseIdentifier"
    var addBook: Bool
    
    weak var delegate: AddBookDelegate?
    
    init(addBook: Bool, addBookDelegate: AddBookDelegate?) {
        self.addBook = addBook
        delegate = addBookDelegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.getUserClubs(user_id: UserID.user_id) { response in
            self.clubs = response
            if (self.addBook) {
                self.header.text = "Select a Club"
            }
            else {
                self.header.text = "My Clubs"
            }
            self.header.textColor = .black
            self.header.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(self.header)
            
            self.clubDisplay.dataSource = self
            self.clubDisplay.delegate = self
            self.clubDisplay.register(ClubTableViewCell.self, forCellReuseIdentifier: self.clubDisplayReuseIdentifier)
            self.clubDisplay.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(self.clubDisplay)
            
            self.setupConstraints()
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//            header.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            clubDisplay.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20),
            clubDisplay.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            clubDisplay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            clubDisplay.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension MyClubsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubs!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = clubDisplay.dequeueReusableCell(withIdentifier: clubDisplayReuseIdentifier, for: indexPath) as? ClubTableViewCell {
            cell.configure(club: clubs![indexPath.row])
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
}
extension MyClubsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (addBook) {
            delegate!.addBook(club: clubs![indexPath.row])
            dismiss(animated: true)
        }
        else {
            navigationController?.pushViewController(SingleClubView(club: clubs![indexPath.row]), animated: true)
        }
    }
}

protocol AddBookDelegate: UIViewController {
    func addBook(club: BookClub)
}
