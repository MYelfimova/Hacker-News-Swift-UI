//
//  PostData.swift
//  Hacker News
//
//  Created by Maria Yelfimova on 04/10/2020.
//

import Foundation

//let arResult: [Int], Decodable

struct Post: Decodable, Identifiable {
    let id: Int
    let title: String
    let score: Int
    let url: String?
}

/*
struct results: Decodable {
    let hits: [Int]
}
*/
