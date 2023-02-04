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
    
    var selectUser: Bool
    weak var userDelegate: SelectUserDelegate?
    var selectUserID: Int?
    
    var addBook: Bool
    weak var bookDelegate: AddBookDelegate?
    
    init(selectUser: Bool, selectUserDelegate: SelectUserDelegate?, selectUserID: Int?, addBook: Bool, addBookDelegate: AddBookDelegate?) {
        self.selectUser = selectUser
        self.userDelegate = selectUserDelegate
        self.selectUserID = selectUserID
        self.addBook = addBook
        bookDelegate = addBookDelegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        NetworkManager.getUserClubs(user_id: UserID.user_id) { response in
            self.clubs = response
            
            self.header.textColor = .systemGray6
            self.header.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
            self.header.layer.shadowOffset = CGSize(width: 3, height: 3)
            self.header.layer.shadowOpacity = 0.8
            self.header.layer.shadowRadius = 4
            self.header.translatesAutoresizingMaskIntoConstraints = false
            
            if (self.addBook) {
                self.header.text = "Select a Club"
            }
            else {
                self.header.text = "My Clubs"
            }
            
            self.view.addSubview(self.header)
            
            if (self.selectUser) {
                NetworkManager.getUserClubs(user_id: self.selectUserID!) { response in
                    for club in response {
                        print("reached")
                        print(club.id)
                        var index = 0
                        for _ in 0...self.clubs!.count - 1 {
                            print(self.clubs!.count)
                            print("index" + "\(index)")
                            if (self.clubs![index].id == club.id) {
                                print("reached")
                                self.clubs!.remove(at: index)
                                index -= 1
                            }
                            index += 1
                        }
                    }
                    self.clubDisplay.backgroundColor = .systemCyan
                    self.clubDisplay.dataSource = self
                    self.clubDisplay.delegate = self
                    self.clubDisplay.register(ClubTableViewCell.self, forCellReuseIdentifier: self.clubDisplayReuseIdentifier)
                    self.clubDisplay.translatesAutoresizingMaskIntoConstraints = false
                    self.view.addSubview(self.clubDisplay)
                    
                    self.setupConstraints()
                }
            }
            else {
                self.clubDisplay.backgroundColor = .systemCyan
                self.clubDisplay.dataSource = self
                self.clubDisplay.delegate = self
                self.clubDisplay.register(ClubTableViewCell.self, forCellReuseIdentifier: self.clubDisplayReuseIdentifier)
                self.clubDisplay.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(self.clubDisplay)
                
                self.setupConstraints()
            }
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            clubDisplay.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 10),
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (addBook) {
            bookDelegate!.addBook(club: clubs![indexPath.row])
            dismiss(animated: true)
        }
        else if (selectUser) {
            userDelegate!.selectUser(club: clubs![indexPath.row], user_id: selectUserID!)
            dismiss(animated: true)
        }
        else {
            navigationController?.pushViewController(SingleClubView(club: clubs![indexPath.row], joinClub: false), animated: true)
        }
    }
}

protocol AddBookDelegate: UIViewController {
    func addBook(club: BookClub)
}

protocol SelectUserDelegate: UIViewController {
    func selectUser(club: BookClub, user_id: Int)
}
