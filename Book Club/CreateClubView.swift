//
//  CreateClubView.swift
//  Book Club
//
//  Created by Nick Brenner on 1/30/23.
//

import Foundation
import UIKit

class CreateClubView: UIViewController {
    var clubName = UITextField()
    var submitButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        clubName.placeholder = "Club Name..."
        clubName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(clubName)
        
        submitButton.setTitle("Create", for: .normal)
        submitButton.backgroundColor = .blue
        submitButton.addTarget(self, action: #selector(submitFunc), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(submitButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            clubName.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            clubName.heightAnchor.constraint(equalToConstant: 50),
            clubName.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            clubName.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: clubName.bottomAnchor, constant: 50),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func submitFunc() {
        NetworkManager.userCreateBookClub(user_id: UserID.user_id, name: clubName.text!) { response in
        }
        dismiss(animated: true)
    }
}
