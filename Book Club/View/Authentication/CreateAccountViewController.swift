//
//  CreateAccountViewController.swift
//  Book Club
//
//  Created by Nick Brenner on 2/2/23.
//

import Foundation
import UIKit

class CreateAccountViewController: UIViewController {
    var welcomeLabel = UILabel()
    var name = UITextField()
    var username = UITextField()
    var password = UITextField()
    var createButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemCyan
        
        welcomeLabel.text = "Let's Get You Reading"
        welcomeLabel.textColor = .systemGray6
        welcomeLabel.font = UIFont(name: "Helvetica-Bold", size: 30)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)
        
        name.attributedPlaceholder = NSAttributedString(
            string: "Name...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4, NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 20)]
        )
        name.textAlignment = .center
        name.textColor = .black
        name.font = UIFont(name: "Helvetica-Bold", size: 20)
        name.autocapitalizationType = .words
        name.backgroundColor = .white
        name.layer.cornerRadius = 8
        name.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(name)
        
        username.attributedPlaceholder = NSAttributedString(
            string: "Username...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4, NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 20)]
        )
        username.textAlignment = .center
        username.textColor = .black
        username.font = UIFont(name: "Helvetica-Bold", size: 20)
        username.autocapitalizationType = .none
        username.backgroundColor = .white
        username.layer.cornerRadius = 8
        username.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(username)
        
        password.attributedPlaceholder = NSAttributedString(
            string: "Password...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4, NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 20)]
        )
        password.textAlignment = .center
        password.textColor = .black
        password.font = UIFont(name: "Helvetica-Bold", size: 20)
        password.autocapitalizationType = .none
        password.backgroundColor = .white
        password.layer.cornerRadius = 8
        password.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(password)
        
        createButton.backgroundColor = .systemBlue
        createButton.layer.cornerRadius = 8
        createButton.setTitle("Create Account", for: .normal)
        createButton.titleLabel!.textColor = .white
        createButton.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        createButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
        createButton.contentMode = .scaleAspectFit
        createButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 60),
            name.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            name.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            name.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07)
        ])
        
        NSLayoutConstraint.activate([
            username.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 45),
            username.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            username.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            username.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07)
        ])
        
        NSLayoutConstraint.activate([
            password.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 45),
            password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            password.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            password.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07)
        ])
        
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 60),
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            createButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08)
        ])
    }
    
    @objc func createAccount() {
        NetworkManager.createUser(name: name.text!, username: username.text!, password: password.text!) { response in
            self.navigationController?.pushViewController(HomeScreenViewController(user_id: response.user_id), animated: true)
        }
    }
}
