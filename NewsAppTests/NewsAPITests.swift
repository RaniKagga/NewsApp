//
//  NewsAPITests.swift
//  NewsAppTests
//
//  Created by K Nagarani on 06/03/25.
//

import XCTest
@testable import NewsApp

final class NewsAPITests: XCTestCase {

    var mockApiService: MockNewsAPIService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockApiService = MockNewsAPIService()
    }

    override func tearDownWithError() throws {
        mockApiService = nil
        try super.tearDownWithError()
    }
    
    func testFetchNewsArticles() async throws {
        
        //When
        let result = try await mockApiService.fetchNewsArticles()
        switch result {
        case .success(let articles):
            XCTAssertTrue(!articles.isEmpty)
            XCTAssertEqual(articles.first?.title, "Test News")
            XCTAssertEqual(articles.count, 1)
        case .failure(let error):
            XCTFail("Failed to fetch news articles: \(error)")
        }
    }
    
    func testFetchNewsArticlesFailure() async throws {
        let articles = [NewsArticle]()
        
        let result = try await mockApiService.fetchNewsArticles()
        
        switch result {
            case .success(let data):
            XCTAssertNotEqual(data, articles)
        case .failure:
            XCTFail("Failed to fetch news articles")
        }
    }
    
    func testFetchCommentsForArticle() async throws {
        let expectation = expectation(description: "Fetching comments")
        
        let result = try await mockApiService.fetchLikesAndCommentsCount(articleId: "test-id", type: "likes")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            switch result {
            case .success(let count):
                XCTAssertEqual(count, 10)
            case .failure:
                XCTFail("Failed to fetch news articles")
            }
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 5.0, enforceOrder: true)
    }
}

        
        
