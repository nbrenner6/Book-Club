//
//  CreatedClubsViewController.swift
//  Book Club
//
//  Created by Nick Brenner on 2/2/23.
//

import Foundation
import UIKit

class CreatedClubsViewController: UIViewController {
    
    var clubs: [BookClub]?
    var clubTableView = UITableView()
    var header = UILabel()
    var reuseIdentifier = "reuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemCyan
        
        NetworkManager.getBookClubs() { response in
            self.clubs = response
            
            NetworkManager.getUserClubs(user_id: UserID.user_id) { response in
                for club in response {
                    var index = 0
                    for _ in 0...self.clubs!.count - 1 {
                        if (self.clubs![index].id == club.id) {
                            self.clubs!.remove(at: index)
                            index -= 1
                        }
                        index += 1
                    }
                }
                
                self.header.textColor = .white
                self.header.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
                self.header.layer.shadowOffset = CGSize(width: 3, height: 3)
                self.header.layer.shadowOpacity = 0.4
                self.header.layer.shadowRadius = 2
                self.header.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(self.header)

                if (self.clubs!.count != 0) {
                    self.header.text = "Select a Club"
                }
                else {
                    self.header.text = "No Available Clubs"
                }
                
                self.clubTableView.backgroundColor = .systemCyan
                self.clubTableView.dataSource = self
                self.clubTableView.delegate = self
                self.clubTableView.register(ClubTableViewCell.self, forCellReuseIdentifier: self.reuseIdentifier)
                self.clubTableView.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(self.clubTableView)
                
                self.setupConstraints()
            }
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            clubTableView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 5),
            clubTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            clubTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            clubTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension CreatedClubsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubs!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = clubTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? ClubTableViewCell {
            cell.configure(club: clubs![indexPath.row])
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
}

extension CreatedClubsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(SingleClubView(club: self.clubs![indexPath.row], joinClub: true), animated: true)
    }
}
