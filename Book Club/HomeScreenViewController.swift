//
//  HomeScreenViewController.swift
//  Book Club
//
//  Created by Nick Brenner on 2/2/23.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    var searchForBook = UIButton()
    var createClubButton = UIButton()
    var seeClubsButton = UIButton()
    var addUsersButton = UIButton()
    var viewClubsButton = UIButton()
    
    init(user_id: Int) {
        UserID.user_id = user_id
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        searchForBook.setTitle("Search", for: .normal)
        searchForBook.addTarget(self, action: #selector(pushSearchView), for: .touchUpInside)
        searchForBook.backgroundColor = .systemBlue
        searchForBook.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchForBook)
        
        createClubButton.setTitle("Create A New Club", for: .normal)
        createClubButton.addTarget(self, action: #selector(presentCreateClubView), for: .touchUpInside)
        createClubButton.backgroundColor = .systemBlue
        createClubButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createClubButton)
        
        seeClubsButton.setTitle("My Clubs", for: .normal)
        seeClubsButton.addTarget(self, action: #selector(pushSeeClubsView), for: .touchUpInside)
        seeClubsButton.backgroundColor = .systemBlue
        seeClubsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(seeClubsButton)
        
        addUsersButton.setTitle("Add Users To My Club", for: .normal)
        addUsersButton.addTarget(self, action: #selector(seeUsers), for: .touchUpInside)
        addUsersButton.backgroundColor = .systemBlue
        addUsersButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addUsersButton)
        
        viewClubsButton.setTitle("Browse Clubs", for: .normal)
        viewClubsButton.addTarget(self, action: #selector(seeCreatedClubs), for: .touchUpInside)
        viewClubsButton.backgroundColor = .systemBlue
        viewClubsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewClubsButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchForBook.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchForBook.heightAnchor.constraint(equalToConstant: 100),
            searchForBook.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchForBook.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            createClubButton.topAnchor.constraint(equalTo: searchForBook.bottomAnchor, constant: 20),
            createClubButton.heightAnchor.constraint(equalToConstant: 100),
            createClubButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            createClubButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            seeClubsButton.topAnchor.constraint(equalTo: createClubButton.bottomAnchor, constant: 20),
            seeClubsButton.heightAnchor.constraint(equalToConstant: 100),
            seeClubsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            seeClubsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            addUsersButton.topAnchor.constraint(equalTo: seeClubsButton.bottomAnchor, constant: 20),
            addUsersButton.heightAnchor.constraint(equalToConstant: 100),
            addUsersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addUsersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            viewClubsButton.topAnchor.constraint(equalTo: addUsersButton.bottomAnchor, constant: 20),
            viewClubsButton.heightAnchor.constraint(equalToConstant: 100),
            viewClubsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewClubsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func pushSearchView() {
        navigationController?.pushViewController(BookSearchView(), animated: true)
    }
    
    @objc func presentCreateClubView() {
        present(CreateClubView(), animated: true, completion: nil)
    }
    
    @objc func pushSeeClubsView() {
        navigationController?.pushViewController(MyClubsViewController(addBook: false, addBookDelegate: nil), animated: true)
    }
    
    @objc func seeUsers() {
        navigationController?.pushViewController(AddUsersViewController(), animated: true)
    }
    
    @objc func seeCreatedClubs() {
        navigationController?.pushViewController(CreatedClubsViewController(), animated: true)
    }
    
}

struct UserID {
     static var user_id = 0
}


