//
//  ViewController.swift
//  Testing
//
//  Created by Nick Brenner on 1/27/23.
//

import UIKit

class ViewController: UIViewController {
    var iconImage = UIImageView()
    var titleLabel = UILabel()
    var messageLabel = UILabel()
    var loginButton = UIButton()
    var createAccountButton = UIButton()
    var alreadyAccount = UILabel()
    var newAccount = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemCyan
        
        iconImage.image = UIImage(named: "book-icon")
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(iconImage)
        
        titleLabel.text = "Book Club"
        titleLabel.textColor = .systemGray6
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 60)
        titleLabel.layer.shadowOffset = CGSize(width: 3, height: 3)
        titleLabel.layer.shadowOpacity = 0.8
        titleLabel.layer.shadowRadius = 4
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        messageLabel.text = "Let's Read Together"
        messageLabel.textColor = .systemGray6
        messageLabel.font = UIFont(name: "HelveticaNeue-LightItalic", size: 20)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageLabel)
        
        alreadyAccount.text = "Already Have an Account?"
        alreadyAccount.textColor = .systemGray6
        alreadyAccount.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        alreadyAccount.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alreadyAccount)
        
        loginButton.backgroundColor = .systemGreen
        loginButton.layer.cornerRadius = 8
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel!.textColor = .systemGray6
        loginButton.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        loginButton.contentMode = .scaleAspectFit
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        newAccount.text = "Ready to Sign Up?"
        newAccount.textColor = .systemGray6
        newAccount.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        newAccount.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newAccount)
        
        createAccountButton.backgroundColor = .systemBlue
        createAccountButton.layer.cornerRadius = 8
        createAccountButton.setTitle("Create Account", for: .normal)
        createAccountButton.titleLabel!.textColor = .systemGray6
        createAccountButton.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 20)
        createAccountButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
        createAccountButton.contentMode = .scaleAspectFit
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createAccountButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            iconImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: -10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            alreadyAccount.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 200),
            alreadyAccount.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: alreadyAccount.bottomAnchor, constant: 10),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.075)
        ])
        
        NSLayoutConstraint.activate([
            newAccount.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
            newAccount.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            createAccountButton.topAnchor.constraint(equalTo: newAccount.bottomAnchor, constant: 5),
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccountButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            createAccountButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.075)
        ])
    }
    
    @objc func login() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    @objc func createAccount() {
        navigationController?.pushViewController(CreateAccountViewController(), animated: true)
    }
}


