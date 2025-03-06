//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by K Nagarani on 06/03/25.
//

import XCTest
@testable import NewsApp

final class NewsViewModelTests: XCTestCase {

    var viewModel: NewsViewModel!
    var mockNetworkService: MockNewsAPIService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mockNetworkService = MockNewsAPIService()
        viewModel = NewsViewModel(apiService: mockNetworkService)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        mockNetworkService = nil
        viewModel = nil
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchNewsSuccess() {
        let expectation = expectation(description: "Fetching news")
        
        viewModel.fetchNewsArticles()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            XCTAssertNotNil(self.viewModel.newsArticles)
            XCTAssertEqual(self.viewModel.newsArticles.count, 1)
            expectation.fulfill()
        }
        print("testing completed")
        wait(for: [expectation], timeout: 5)
    }

}
