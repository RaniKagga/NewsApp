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
        NavigationStack {
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
            .onAppear {
                newsViewModel.fetchNewsArticles()
            }
        }
    }
}

struct ListView: View {
    let item: NewsArticle
    
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
        }
    }
}

#Preview {
    NewsArticleListView()
}
