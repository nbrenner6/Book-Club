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
            "q": keyword,
            "maxResults": 20
        ]

        AF.request(endpoint, method: .get, parameters: params).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                let result1 = data as! NSDictionary
                let result2 = result1["items"] as! NSArray
                var result3: NSMutableArray = []
                for i in result2 {
                    result3.add(i)
                }
                var index = 0
                var bookEntries: [BookEntry] = []
                for i in 0...result3.count - 1 {
                    let result4 = result3[index] as! NSDictionary
                    let result5 = result4["volumeInfo"] as! NSDictionary
                    if (result5["title"] == nil || result5["authors"] == nil || result5["publishedDate"] == nil
                        || result5["pageCount"] == nil || result5["imageLinks"] == nil) {
                        result3.removeObject(at: index)
                        index -= 1
                    }
                    else {
                        let result6 = result5["imageLinks"] as! NSDictionary
                        let imageLinks = ImageLinks(smallThumbnail: result6["smallThumbnail"] as! String, thumbnail: result6["thumbnail"] as! String)
                        let volumeInfo = VolumeInfo(title: result5["title"] as! String, authors: result5["authors"] as! [String], publishedDate: result5["publishedDate"] as! String, pageCount: result5["pageCount"] as! Int, imageLinks: imageLinks)
                        let bookEntry = BookEntry(volumeInfo: volumeInfo)
                        bookEntries.append(bookEntry)
                    }
                    index += 1
                }
                let books = Books(items: bookEntries)
                completion(books)
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
                           smallThumbnail: String, thumbnail: String, completion: @escaping (Book) -> Void) {
        let endpoint = "\(host2)/books/"

        let params: Parameters = [
            "title": title,
            "author": author,
            "publishedDate": publishedDate,
            "pageCount": pageCount,
            "smallThumbnail": smallThumbnail,
            "thumbnail": thumbnail
        ]
        
        print(title)
        print(author)
        print(publishedDate)
        print(pageCount)
        print(smallThumbnail)
        print(thumbnail)

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


