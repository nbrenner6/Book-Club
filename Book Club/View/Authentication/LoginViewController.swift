//
//  LoginViewController.swift
//  Book Club
//
//  Created by Nick Brenner on 2/2/23.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    var welcomeLabel = UILabel()
    var username = UITextField()
    var password = UITextField()
    var validation = UILabel()
    var loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemCyan
        
        welcomeLabel.text = "Let's Get You Reading"
        welcomeLabel.textColor = .systemGray6
        welcomeLabel.font = UIFont(name: "Helvetica-Bold", size: 30)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)
        
        username.attributedPlaceholder = NSAttributedString(
            string: "Username...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4, NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 20)]
        )
        username.textAlignment = .center
        username.textColor = .black
        username.font = UIFont(name: "Helvetica-Bold", size: 20)
        username.translatesAutoresizingMaskIntoConstraints = false
        username.autocapitalizationType = .none
        username.backgroundColor = .white
        username.layer.cornerRadius = 8
        view.addSubview(username)
        
        password.attributedPlaceholder = NSAttributedString(
            string: "Password...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4, NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 20)]
        )
        password.textAlignment = .center
        password.textColor = .black
        password.font = UIFont(name: "Helvetica-Bold", size: 20)
        password.autocapitalizationType = .none
        password.translatesAutoresizingMaskIntoConstraints = false
        password.backgroundColor = .white
        password.layer.cornerRadius = 8
        view.addSubview(password)
        
        validation.text = "Incorrect Username/Password"
        validation.isHidden = true
        validation.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(validation)
        
        loginButton.backgroundColor = .systemGreen
        loginButton.layer.cornerRadius = 8
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel!.textColor = .systemGray6
        loginButton.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        loginButton.contentMode = .scaleAspectFit
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            username.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 60),
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
            validation.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 15),
            validation.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 60),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08)
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
