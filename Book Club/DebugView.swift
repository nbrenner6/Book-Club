//
//  DebugView.swift
//  Book Club
//
//  Created by Nick Brenner on 2/1/23.
//

import Foundation
import UIKit

class DebugView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NetworkManager.createBook(title: "Test", author: "Test", publishedDate: "Test", pageCount: 5, textSnippet: "Test", smallThumbnail: "Test", thumbnail: "Test") { response in
//            print (response.title)
//        }
        
//        NetworkManager.createBookClub(name: "MyClub") { response in
//            print(response.name)
//        }
        
//        NetworkManager.getUserClubs(user_id: 1) { response in
//            print(response[0].name)
//        }
        
//        NetworkManager.addBookToClub(bookclub_id: 1, book_id: 1) { response in
//            print(response.name)
//        }
        
//        NetworkManager.login(username: "usernam", password: "password") { response in
//        }
        NetworkManager.getUsers() { response in
            
        }
    }
}
