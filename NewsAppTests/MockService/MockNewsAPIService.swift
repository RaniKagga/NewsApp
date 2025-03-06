//
//  MockNewsAPI.swift
//  NewsAppTests
//
//  Created by K Nagarani on 06/03/25.
//

import Foundation
@testable import NewsApp

class MockNewsAPIService: NewsAPIServiceProtocol {
    var baseURL = URL(string: "https://www.example.com/")!
    
    func fetchNewsArticles() async throws -> Result<[NewsArticle], NetworkError> {
        let urlString = baseURL.absoluteString + "apiKey"
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        let jsonString = """
                [
                    {
                        "source": {
                            "id": null,
                            "name": "Test"
                        },
                        "author": "John Wesley",
                        "title": "Test News",
                        "description": "This is a test description.",
                        "url": "https://test.com",
                        "urlToImage": "https://test.com/image.jpg",
                        "publishedAt": "December 4th 2024",
                        "content": "Test Content"
                    }
                ]
                """
        
        let jsonData = jsonString.data(using: .utf8)!
        print(jsonData)
        do {
            return .success(try JSONDecoder().decode([NewsArticle].self, from: jsonData))
        } catch {
            return .failure(.decodingFailed)
        }
    }
    
    func fetchLikesAndCommentsCount(articleId: String, type: String) async throws -> Result<Int, NewsApp.NetworkError> {
        return .success(10)
    }
    
}
