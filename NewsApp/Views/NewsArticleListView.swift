//
//  NewsArticleListView.swift
//  NewsApp
//
//  Created by K Nagarani on 05/03/25.
//

import SwiftUI

struct NewsArticleListView: View {
    
    @State private var isLoading = false
    @EnvironmentObject var newsViewModel: NewsViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if newsViewModel.isLoading {
                    ProgressView("Loading news...")
                } else if let error = newsViewModel.errorMessage {
                    VStack {
                        Text(error)
                            .font(.title)
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                        Button("Retry") {
                            newsViewModel.fetchNewsArticles()
                        }.buttonStyle(.borderedProminent)
                            .padding()
                    }
                } else {
                    List(newsViewModel.newsArticles) { article in
                        NavigationLink(destination: NewsArticleDetailView(article: article)) {
                            ListView(item: article)
                                
                        }
                    }.refreshable {
                        newsViewModel.fetchNewsArticles()
                    }
                }
            }.navigationBarTitle("News")
            .task {
                newsViewModel.fetchNewsArticles()
            }
        }
    }
}

struct ListView: View {
    let item: NewsArticle
    @EnvironmentObject var bookmarksVM: BookmarksViewModel
    @State private var bookmarked: Bool = false
    
    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: item.urlToImage ?? "")) { image in
                image.resizable()
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .foregroundStyle(.gray)
            }.frame(width: 100, height: 100)
                .aspectRatio(contentMode: .fill)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(item.description ?? "No Description Available")
                Text("Published by: \(item.author ?? "Unknown Author")")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Image(systemName: (bookmarked ? "bookmark.fill" : "bookmark"))
        }.onAppear {
            bookmarked = bookmarksVM.isBookmarked(item)
        }.swipeActions {
            Button {
                if bookmarked {
                    bookmarksVM.removeBookmark(item)
                } else {
                    bookmarksVM.addBookmark(item)
                }
                bookmarked.toggle()
            } label: {
                Image(systemName: (bookmarked ? "bookmark.fill" : "bookmark"))
            }

        }
    }
}

#Preview {
    NewsArticleListView()
}
