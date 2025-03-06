//
//  Article.swift
//  NewsApp
//
//  Created by K Nagarani on 05/03/25.
//

import Foundation

struct NewsArticleResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [NewsArticle]
}

struct NewsArticle: Codable, Identifiable, Equatable {
    static func == (lhs: NewsArticle, rhs: NewsArticle) -> Bool {
        return true
    }
    
    let id = UUID()
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String
}
