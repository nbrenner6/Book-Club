//
//  HomeScreenViewController.swift
//  Book Club
//
//  Created by Nick Brenner on 2/2/23.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    var hubLabel = UILabel()
    var searchForBook = UIButton()
    var createClubButton = UIButton()
    var seeClubsButton = UIButton()
    var addUsersButton = UIButton()
    var viewClubsButton = UIButton()
    
    var searchBooksLabel = UILabel()
    var myClubsLabel = UILabel()
    var createClubLabel = UILabel()
    var browseUsersLabel = UILabel()
    var browseClubsLabel = UILabel()
    
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
        view.backgroundColor = .systemCyan
        
        hubLabel.text = "My Reading Hub"
        hubLabel.textColor = .systemGray6
        hubLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        hubLabel.layer.shadowOffset = CGSize(width: 3, height: 3)
        hubLabel.layer.shadowOpacity = 0.8
        hubLabel.layer.shadowRadius = 4
        hubLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hubLabel)
        
        searchBooksLabel.text = "Find New Books"
        searchBooksLabel.textColor = .systemGray6
        searchBooksLabel.font = UIFont(name: "Helvetica", size: 20)
        searchBooksLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBooksLabel)
        
        myClubsLabel.text = "My Clubs"
        myClubsLabel.textColor = .systemGray6
        myClubsLabel.font = UIFont(name: "HelveticaNeue", size: 20)
        myClubsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(myClubsLabel)
        
        createClubLabel.text = "Create a Club"
        createClubLabel.textColor = .systemGray6
        createClubLabel.font = UIFont(name: "Helvetica", size: 20)
        createClubLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createClubLabel)
        
        browseUsersLabel.text = "Invite Users"
        browseUsersLabel.textColor = .systemGray6
        browseUsersLabel.font = UIFont(name: "Helvetica", size: 20)
        browseUsersLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(browseUsersLabel)
        
        browseClubsLabel.text = "Join a New Club"
        browseClubsLabel.textColor = .systemGray6
        browseClubsLabel.font = UIFont(name: "Helvetica", size: 20)
        browseClubsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(browseClubsLabel)
        
        searchForBook.setImage(UIImage(named: "search_book_icon"), for: .normal)
        searchForBook.contentMode = .scaleAspectFit
        searchForBook.layer.cornerRadius = 20
        searchForBook.addTarget(self, action: #selector(pushSearchView), for: .touchUpInside)
        searchForBook.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchForBook)
        
        createClubButton.setImage(UIImage(named: "create_club_icon"), for: .normal)
        createClubButton.layer.cornerRadius = 20
        createClubButton.contentMode = .scaleAspectFit
        createClubButton.addTarget(self, action: #selector(presentCreateClubView), for: .touchUpInside)
        createClubButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(createClubButton)
        
        seeClubsButton.setImage(UIImage(named: "my_clubs_icon"), for: .normal)
        seeClubsButton.contentMode = .scaleAspectFit
        seeClubsButton.layer.cornerRadius = 20
        seeClubsButton.addTarget(self, action: #selector(pushSeeClubsView), for: .touchUpInside)
        seeClubsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(seeClubsButton)
        
        addUsersButton.setImage(UIImage(named: "see_users_icon"), for: .normal)
        addUsersButton.contentMode = .scaleAspectFit
        addUsersButton.layer.cornerRadius = 20
        addUsersButton.addTarget(self, action: #selector(seeUsers), for: .touchUpInside)
        addUsersButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addUsersButton)
        
        viewClubsButton.setImage(UIImage(named: "search_clubs_icon"), for: .normal)
        viewClubsButton.contentMode = .scaleAspectFit
        viewClubsButton.layer.cornerRadius = 20
        viewClubsButton.addTarget(self, action: #selector(seeCreatedClubs), for: .touchUpInside)
        viewClubsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewClubsButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            hubLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            hubLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            seeClubsButton.topAnchor.constraint(equalTo: hubLabel.bottomAnchor, constant: 5),
            seeClubsButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            seeClubsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35),
            seeClubsButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25)
        ])
        
        NSLayoutConstraint.activate([
            myClubsLabel.topAnchor.constraint(equalTo: seeClubsButton.bottomAnchor, constant: -30),
            myClubsLabel.centerXAnchor.constraint(equalTo: seeClubsButton.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            createClubButton.topAnchor.constraint(equalTo: hubLabel.bottomAnchor, constant: 5),
            createClubButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            createClubButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35),
            createClubButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25)
        ])
        
        NSLayoutConstraint.activate([
            createClubLabel.topAnchor.constraint(equalTo: createClubButton.bottomAnchor, constant: -30),
            createClubLabel.centerXAnchor.constraint(equalTo: createClubButton.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            searchForBook.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchForBook.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),
            searchForBook.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            searchForBook.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            searchBooksLabel.topAnchor.constraint(equalTo: searchForBook.bottomAnchor, constant: -25),
            searchBooksLabel.centerXAnchor.constraint(equalTo: searchForBook.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            addUsersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            addUsersButton.centerXAnchor.constraint(equalTo: seeClubsButton.centerXAnchor),
            addUsersButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            addUsersButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35)
        ])
        
        NSLayoutConstraint.activate([
            browseUsersLabel.topAnchor.constraint(equalTo: addUsersButton.bottomAnchor, constant: -30),
            browseUsersLabel.centerXAnchor.constraint(equalTo: addUsersButton.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            viewClubsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            viewClubsButton.centerXAnchor.constraint(equalTo: createClubButton.centerXAnchor),
            viewClubsButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            viewClubsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35)
        ])
        
        NSLayoutConstraint.activate([
            browseClubsLabel.topAnchor.constraint(equalTo: viewClubsButton.bottomAnchor, constant: -30),
            browseClubsLabel.centerXAnchor.constraint(equalTo: viewClubsButton.centerXAnchor)
        ])
    }
    
    @objc func pushSearchView() {
        navigationController?.pushViewController(BookSearchView(), animated: true)
    }
    
    @objc func presentCreateClubView() {
        present(CreateClubView(), animated: true, completion: nil)
    }
    
    @objc func pushSeeClubsView() {
        navigationController?.pushViewController(MyClubsViewController(selectUser: false, selectUserDelegate: nil, selectUserID: nil, addBook: false, addBookDelegate: nil), animated: true)
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


