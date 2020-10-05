//
//  NetworkManager.swift
//  Hacker News
//
//  Created by Maria Yelfimova on 04/10/2020.
//

import Foundation

class NetworkManager: ObservableObject {
    
    var list_url = [Int]()
    @Published var posts = [Post]()
    
    func fetchDataList() {
        
        func getData(myURL: String) {
                   if let url = URL(string: myURL) {
                       let session = URLSession(configuration: .default)
                       let task = session.dataTask(with: url) { (data, response, erorr) in
                           if erorr == nil {
                               let decoder = JSONDecoder()
                               if let safeData = data {
                                   do {
                                       let results = try decoder.decode(Post.self, from: safeData)
                                        DispatchQueue.main.async {
                                           self.posts.append(results)
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
                                //completion(self.list_url)
                                //print("array list = \(self.list_url)")
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            //var i = 0
            for i in self.list_url { //in 0..<15  { //
                let url = "https://hacker-news.firebaseio.com/v0/item/\(i).json"
                print(url)
                getData(myURL: url)
            }
            print(self.posts)
        }
    }
}


/*
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
 }*/
