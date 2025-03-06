//
//  NewAPIService.swift
//  NewsApp
//
//  Created by K Nagarani on 05/03/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case decodingFailed
    case noData
    case unKnown
}

class NewAPIService {
//    private init () {}
//    static let shared = NewAPIService()
    private let apiKey = "3d85373dc0c84b7a8b687bcd6366d683"//"API_KEY"
    private let baseURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=")!
    
    func fetchNewsArticles() async throws -> Result<[NewsArticle], NetworkError> {
        let urlString = baseURL.absoluteString + apiKey
        guard let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
       
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let stringResp = String(data: data, encoding: .utf8)
            print(stringResp)
            do {
                let response = try JSONDecoder().decode(NewsArticleResponse.self, from: data)
                return .success(response.articles)
            } catch let error as DecodingError {
                handleDecodingError(error)
                return .failure(.decodingFailed)
            } catch {
                return .failure(.unKnown)
            }
        } catch {
            print(error.localizedDescription)
            return .failure(.noData)
        }
    }
    
    private func handleDecodingError(_ error: DecodingError)  {
        switch error {
        case .typeMismatch(let any, _):
            print("Type mismatch for type: \(any)")
        case .valueNotFound(let any, _):
            print("Value not found for type: \(any)")
        case .keyNotFound(let codingKey, _):
            print("Key not found for key: \(codingKey)")
        case .dataCorrupted(let context):
            print("Data corrupted: \(context.debugDescription)")
        @unknown default:
            print("Unknown decoding error")
        }
    }
    
    func fetchLikesAndCommentsCount(articleId: String, type: String) async throws -> Result<Int, NetworkError> {
        
        let id = convertUrlToArticleId(articleId)
        
        guard let url = URL(string: "https://cn-news-info-api.herokuapp.com/\(type)/\(id)") else {
            fatalError("error")
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let count = String(data: data, encoding: .utf8)!
            print("\(type) count - \(count)")
            do {
                if type == "likes" {
                    let resp = try JSONDecoder().decode(LikesResponse.self, from: data)
                    return .success(resp.likes)
                } else {
                    let resp = try JSONDecoder().decode(CommentsResponse.self, from: data)
                    return .success(resp.comments)
                }
            } catch {
                return .failure(.decodingFailed)
            }
        } catch {
            return .failure(.noData)
        }
    }
}
