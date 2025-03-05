//
//  String+ArticleId.swift
//  NewsApp
//
//  Created by K Nagarani on 05/03/25.
//

import Foundation

func convertUrlToArticleId(_ article: String) -> String {
    
    return article.replacingOccurrences(of: "https://", with: "").replacingOccurrences(of: "/", with: "-").trimmingCharacters(in: .whitespaces)
}
