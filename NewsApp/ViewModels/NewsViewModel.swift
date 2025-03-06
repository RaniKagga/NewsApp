//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by K Nagarani on 05/03/25.
//

import Foundation
import SwiftUI

class NewsViewModel: ObservableObject, @unchecked Sendable {
    @Published var newsArticles: [NewsArticle] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var likesCount: Int = 0
    @Published var commentsCount: Int = 0
    private var newsApiService: NewsAPIServiceProtocol
    
    init(apiService: NewsAPIServiceProtocol = NewsAPIService()) {
        newsApiService = apiService
    }
    
    func fetchNewsArticles() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let newsArticles = try await newsApiService.fetchNewsArticles()
                DispatchQueue.main.async {
                    self.isLoading = false
                    switch newsArticles {
                    case .success(let articles):
                        self.newsArticles = articles
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                    }
                }
            } catch {
                self.isLoading = false
                self.errorMessage = error.localizedDescription
            }
        }
    }

    func fetchLikes(_ url: String) {
        Task {
            do {
                let likesCount = try await newsApiService.fetchLikesAndCommentsCount(articleId: url, type: "likes")
                DispatchQueue.main.async {
                    switch likesCount {
                    case .success(let count):
                        self.likesCount = count
                    case .failure(let error):
                        print("Error while fetching Likes: \(error.localizedDescription)")
                    }
                }
            } catch {
                print("Error while fetching Likes: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchComments(_ url: String) {
        Task {
            do {
                let commentsCount = try await newsApiService.fetchLikesAndCommentsCount(articleId: url, type: "comments")
                DispatchQueue.main.async {
                    switch commentsCount {
                    case .success(let count):
                        self.commentsCount = count
                    case .failure(let error):
                        print("Error while fetching Comments: \(error.localizedDescription)")
                    }
                }
            } catch {
                print("Error while fetching Comments: \(error.localizedDescription)")
            }
        }
    }
}
