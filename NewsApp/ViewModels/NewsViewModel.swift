//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by K Nagarani on 05/03/25.
//

import Foundation

class NewsViewModel: ObservableObject {
    @Published var newsArticles: [NewsArticle] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var likesCount: Int = 0
    @Published var commentsCount: Int = 0
    
    func fetchNewsArticles() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let newsArticles = try await NewAPIService.shared.fetchNewsArticles()
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
                let likesCount = try await NewAPIService.shared.fetchLikesAndCommentsCount(articleId: url, type: "likes")
                DispatchQueue.main.async {
                    switch likesCount {
                    case .success(let count):
                        self.likesCount = count
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                    }
                }
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func fetchComments(_ url: String) {
        Task {
            do {
                let commentsCount = try await NewAPIService.shared.fetchLikesAndCommentsCount(articleId: url, type: "comments")
                DispatchQueue.main.async {
                    switch commentsCount {
                    case .success(let count):
                        self.commentsCount = count
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                    }
                }
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
}
