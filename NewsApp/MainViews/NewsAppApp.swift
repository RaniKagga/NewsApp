//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by K Nagarani on 05/03/25.
//

import SwiftUI

@main
struct NewsAppApp: App {
    @StateObject private var newsViewModel = NewsViewModel()
    @StateObject private var bookmarksViewModel = BookmarksViewModel()
    
    var body: some Scene {
        WindowGroup {
            NewsArticleListView()
                .environmentObject(newsViewModel)
                .environmentObject(bookmarksViewModel)
        }
    }
}
