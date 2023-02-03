//
//  NetworkManager.swift
//  Book Club
//
//  Created by Nick Brenner on 1/27/23.
//

import Foundation
import Alamofire
import Combine

class NetworkManager: ObservableObject {
    static let host1 = "https://www.googleapis.com/books/v1/volumes"
    static let host2 = "http://localhost:8000"
    
    static func search(keyword: String, completion: @escaping (Books) -> Void) {
        let endpoint = host1

        let params: Parameters = [
            "q": keyword
        ]

        AF.request(endpoint, method: .get, parameters: params).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let books = try? jsonDecoder.decode(Books.self, from: data) {
                    completion(books)
                } else {
                    print("Failed to decode")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func createUser(name: String, username: String, password: String, completion: @escaping (SessionToken) -> Void) {
        let endpoint = "\(host2)/users/register/"

        let params: Parameters = [
            "name": name,
            "username": username,
            "password": password
        ]

        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let response = try? jsonDecoder.decode(SessionToken.self, from: data) {
                    completion(response)
                } else {
                    print("Failed to decode")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func createBookClub(name: String, completion: @escaping (BookClub) -> Void) {
        let endpoint = "\(host2)/bookclubs/"

        let params: Parameters = [
            "name": name
        ]

        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let response = try? jsonDecoder.decode(BookClub.self, from: data) {
                    completion(response)
                } else {
                    print("Failed to decode")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func userCreateBookClub(user_id: Int, name: String, completion: @escaping (BookClub) -> Void) {
        let endpoint = "\(host2)/users/\(user_id)/bookclubs/"

        let params: Parameters = [
            "name": name
        ]

        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let response = try? jsonDecoder.decode(BookClub.self, from: data) {
                    completion(response)
                } else {
                    print("Failed to decode")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func createBook(title: String, author: String, publishedDate: String, pageCount: Int,
                           textSnippet: String, smallThumbnail: String, thumbnail: String, completion: @escaping (Book) -> Void) {
        let endpoint = "\(host2)/books/"

        let params: Parameters = [
            "title": title,
            "author": author,
            "publishedDate": publishedDate,
            "pageCount": pageCount,
            "textSnippet": textSnippet,
            "smallThumbnail": smallThumbnail,
            "thumbnail": thumbnail
        ]

        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let response = try? jsonDecoder.decode(Book.self, from: data) {
                    completion(response)
                } else {
                    print("Failed to decode")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getUsers(completion: @escaping ([User]) -> Void) {
        let endpoint = "\(host2)/users/"

        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let response = try? jsonDecoder.decode(Users.self, from: data) {
                    completion(response.users)
                } else {
                    print("Failed to decode")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getBookClubs(completion: @escaping ([BookClub]) -> Void) {
        let endpoint = "\(host2)/bookclubs/"

        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let books = try? jsonDecoder.decode(GeneralBookClubs.self, from: data) {
                    completion(books.bookclubs)
                } else {
                    print("Failed to decode")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func addBookToClub(bookclub_id: Int, book_id: Int, completion: @escaping (BookClub) -> Void) {
        let endpoint = "\(host2)/bookclubs/\(bookclub_id)/books/add/"
        
        let params: Parameters = [
            "book_id": book_id
        ]

        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let books = try? jsonDecoder.decode(BookClub.self, from: data) {
                    completion(books)
                } else {
                    print("Failed to decode")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func addUserToClub(bookclub_id: Int, user_id: Int, completion: @escaping (BookClub) -> Void) {
        let endpoint = "\(host2)/bookclubs/\(bookclub_id)/users/add/"
        
        let params: Parameters = [
            "user_id": user_id
        ]

        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let books = try? jsonDecoder.decode(BookClub.self, from: data) {
                    completion(books)
                } else {
                    print("Failed to decode")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getUserClubs(user_id: Int, completion: @escaping ([BookClub]) -> Void) {
        let endpoint = "\(host2)/users/\(user_id)/bookclubs/"

        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let response = try? jsonDecoder.decode(UserBookClubs.self, from: data) {
                    completion(response.user_bookclubs)
                } else {
                    print("Failed to decode")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func login(username: String, password: String, completion: @escaping (SessionToken?) -> Void) {
        let endpoint = "\(host2)/users/login/"
        
        let params: Parameters = [
            "username": username,
            "password": password
        ]
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(SessionToken.self, from: data) {
                    completion(userResponse)
                } else {
                    print("Failed to decode createPost")
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}


