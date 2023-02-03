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
    var userTableView = UITableView()
    let reuseIdentifier = "reuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.getUsers() { response in
            self.users = response
            self.userTableView.dataSource = self
            self.userTableView.delegate = self
            self.userTableView.register(UserTableViewCell.self, forCellReuseIdentifier: self.reuseIdentifier)
            self.userTableView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(self.userTableView)
            
            self.setupConstraints()
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            userTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
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
        return 50
    }
}
