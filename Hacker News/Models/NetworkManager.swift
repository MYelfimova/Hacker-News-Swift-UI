//
//  NetworkManager.swift
//  Hacker News
//
//  Created by Maria Yelfimova on 04/10/2020.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var list_url = [Int]()
    @Published var posts = [Post]()
    
    func fetchDataList() {
        if let list_url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json") {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: list_url) { (data, response, erorr) in
                if erorr == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        print("safeData = \(safeData)")
                        do {
                            let results = try decoder.decode([Int].self, from: safeData)
                            DispatchQueue.main.async {
                                self.list_url = results
                                print("array list = \(self.list_url)")
                            }
                            
                        }
                        catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func fetchData() {
        // create URL from a String
        
       // func getData(myURL: String) {
            
            if let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/24648722.json") {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, erorr) in
                    if erorr == nil {
                        let decoder = JSONDecoder()
                        if let safeData = data {
                            
                            print("safeData = \(safeData)")
                            do {
                                let results = try decoder.decode(Post.self, from: safeData)
                                self.posts.append(results)
                                print("self.posts = \(self.posts)")
                            }
                            catch {
                                print(error)
                            }
                        }
                    }
                }
                
                task.resume()
            }
        }
//        for i in list_url {
//            let url = "https://hacker-news.firebaseio.com/v0/item/\(i).json"
//            print(url)
//            //getData(myURL: url)
//        }
   // }
    
}
