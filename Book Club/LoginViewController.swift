//
//  LoginViewController.swift
//  Book Club
//
//  Created by Nick Brenner on 2/2/23.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    var username = UITextField()
    var password = UITextField()
    var validation = UILabel()
    var loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        username.placeholder = "Username..."
        username.translatesAutoresizingMaskIntoConstraints = false
        username.autocapitalizationType = .none
        view.addSubview(username)
        
        password.placeholder = "Password..."
        password.autocapitalizationType = .none
        password.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(password)
        
        validation.text = "Incorrect Username/Password"
        validation.isHidden = true
        validation.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(validation)
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .cyan
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            username.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            username.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            password.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 20),
            password.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            validation.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 15),
            validation.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: validation.bottomAnchor, constant: 10),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func login() {
        NetworkManager.login(username: username.text!, password: password.text!) { response in
            if (response != nil) {
                self.navigationController?.pushViewController(HomeScreenViewController(user_id: response!.user_id), animated: true)
            }
            else {
                self.validation.isHidden = false
            }
        }
    }
}
