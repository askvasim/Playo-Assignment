//
//  NewsEntity.swift
//  Assignment
//
//  Created by Vasim Khan on 8/3/22.
//

import Foundation

struct ArticleData: Codable {
    let articles: [Articles]
}

struct Articles: Codable {
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
}
