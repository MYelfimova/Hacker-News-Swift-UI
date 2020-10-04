//
//  ContentView.swift
//  Hacker News
//
//  Created by Maria Yelfimova on 04/10/2020.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkMangaer = NetworkManager()
    
    var body: some View {
        NavigationView {
            List(networkMangaer.posts) { post in
                Text(post.title).foregroundColor(.black)
            }
            .navigationTitle("Hacker News")
        }
        .onAppear {
            self.networkMangaer.fetchDataList()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*struct Post: Identifiable {
    let id: String
    let title: String
}

let posts = [
    Post(id: 1, title: "Hello"),
    Post(id: 2, title: "Bonjour"),
    Post(id: 3, title: "Hola")
]
 */
