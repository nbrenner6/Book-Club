//
//  AddUserViewController.swift
//  Book Club
//
//  Created by Nick Brenner on 2/2/23.
//

import Foundation
import UIKit

class AddUsersViewController: UIViewController {
    
    var users: [User]?
    var header = UILabel()
    var userTableView = UITableView()
    let reuseIdentifier = "reuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        
        NetworkManager.getUsers() { response in
            self.users = response
            
            self.header.text = "Select a User"
            self.header.textColor = .systemGray6
            self.header.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
            self.header.layer.shadowOffset = CGSize(width: 3, height: 3)
            self.header.layer.shadowOpacity = 0.8
            self.header.layer.shadowRadius = 4
            self.header.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(self.header)
            
            self.userTableView.backgroundColor = .systemCyan
            self.userTableView.dataSource = self
            self.userTableView.delegate = self
            self.userTableView.register(UserTableViewCell.self, forCellReuseIdentifier: self.reuseIdentifier)
            self.userTableView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(self.userTableView)
            
            var index = 0
            for _ in 0...self.users!.count - 1 {
                if (self.users![index].id == UserID.user_id) {
                    self.users!.remove(at: index)
                    index -= 1
                }
                index += 1
            }
            
            self.setupConstraints()
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userTableView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 10),
            userTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            userTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension AddUsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = userTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? UserTableViewCell {
            cell.configure(user: users![indexPath.row])
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
}

extension AddUsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        present(MyClubsViewController(selectUser: true, selectUserDelegate: self, selectUserID: self.users![indexPath.row].id, addBook: false, addBookDelegate: nil), animated: true, completion: nil)
    }
}

extension AddUsersViewController: SelectUserDelegate {
    func selectUser(club: BookClub, user_id: Int) {
        NetworkManager.addUserToClub(bookclub_id: club.id, user_id: user_id) { response in
        }
    }
}
