//
//  ViewController.swift
//  Testing
//
//  Created by Nick Brenner on 1/27/23.
//

import UIKit

class ViewController: UIViewController {
    var loginButton = UIButton()
    var createAccountButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.backgroundColor = .cyan
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        createAccountButton.backgroundColor = .cyan
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createAccountButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            createAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            createAccountButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)
        ])
    }
    
    @objc func login() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc func createAccount() {
        navigationController?.pushViewController(CreateAccountViewController(), animated: true)
    }
}


