//
//  CreateAccountViewController.swift
//  Book Club
//
//  Created by Nick Brenner on 2/2/23.
//

import Foundation
import UIKit

class CreateAccountViewController: UIViewController {
    var name = UITextField()
    var username = UITextField()
    var password = UITextField()
    var createButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        name.placeholder = "Name..."
        name.autocapitalizationType = .words
        name.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(name)
        
        username.placeholder = "Username..."
        username.autocapitalizationType = .none
        username.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(username)
        
        password.placeholder = "Password..."
        password.autocapitalizationType = .none
        password.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(password)
        
        createButton.setTitle("Create Account", for: .normal)
        createButton.backgroundColor = .cyan
        createButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            name.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            username.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            username.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            password.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 20),
            password.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 20),
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func createAccount() {
        NetworkManager.createUser(name: name.text!, username: username.text!, password: password.text!) { response in
            self.navigationController?.pushViewController(HomeScreenViewController(user_id: response.user_id), animated: true)
        }
    }
    
}
