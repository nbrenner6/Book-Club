//
//  CreateClubView.swift
//  Book Club
//
//  Created by Nick Brenner on 1/30/23.
//

import Foundation
import UIKit

class CreateClubView: UIViewController {
    var header = UILabel()
    var clubName = UITextField()
    var submitButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemCyan
        
        header.text = "Create a New Club"
        header.textColor = .systemGray6
        header.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        header.layer.shadowOffset = CGSize(width: 3, height: 3)
        header.layer.shadowOpacity = 0.8
        header.layer.shadowRadius = 4
        header.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(header)
        
        clubName.attributedPlaceholder = NSAttributedString(
            string: "Name...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray6, NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 20)]
        )
        clubName.textAlignment = .center
        clubName.textColor = .systemGray6
        clubName.font = UIFont(name: "Helvetica-Bold", size: 20)
        clubName.autocapitalizationType = .words
        clubName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(clubName)
        
        submitButton.backgroundColor = .systemBlue
        submitButton.layer.cornerRadius = 8
        submitButton.setTitle("Create", for: .normal)
        submitButton.titleLabel!.textColor = .systemGray6
        submitButton.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        submitButton.addTarget(self, action: #selector(submitFunc), for: .touchUpInside)
        submitButton.contentMode = .scaleAspectFit
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(submitButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            clubName.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 50),
            clubName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: clubName.bottomAnchor, constant: 70),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            submitButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
    
    @objc func submitFunc() {
        NetworkManager.userCreateBookClub(user_id: UserID.user_id, name: clubName.text!) { response in
        }
        dismiss(animated: true)
    }
}
