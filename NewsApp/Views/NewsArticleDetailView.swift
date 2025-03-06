//
//  NewsArticleDetailView.swift
//  NewsApp
//
//  Created by K Nagarani on 05/03/25.
//

import SwiftUI

struct NewsArticleDetailView: View {
    let article: NewsArticle
    @State private var likesCount: String = ""
    @State private var commentsCount: String = ""
    @EnvironmentObject var newsViewModel: NewsViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                Text(article.title)
                    .font(.title)
                    .fontWeight(.bold)
                Text(article.description ?? "No Description Available")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
                Text("-")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.green)
                Text("By \(article.author ?? "Unknown Author")")
                    .fontWeight(.semibold)
                Text("\(formatDate(article.publishedAt))")
                    .foregroundStyle(.gray)
                
                HStack(spacing: 20) {
                    Spacer()
                    Label("Likes: \(newsViewModel.likesCount)", systemImage: "hand.thumbsup.fill")
                    Spacer()
                    Label("Comments: \(newsViewModel.commentsCount)", systemImage: "ellipsis.message")
                    Spacer()
                }.padding()
                
                AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .foregroundStyle(.gray)
                }.frame(maxWidth: .infinity)
                    .frame(height: 150)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(8)
                
                Text(article.content ?? "")
                    .multilineTextAlignment(.leading)
                    .padding()
                    .lineLimit(nil)
                
                HStack {
                    Button(action: {
                        if let url = URL(string: article.url) {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text("Read More")
                            .padding()
                            .cornerRadius(10)
                            .foregroundStyle(.white)
                            .background(.blue)
                        
                    }
                    Spacer()
                    Button {
                        SpeechManager.shared.speak(article.description ?? article.content ?? article.title)
                    } label: {
                        Label("Read Content Loudly", systemImage: "speaker.wave.2.circle")
                            .padding()
                            .cornerRadius(10)
                            .foregroundStyle(.white)
                            .background(.blue)
                    }
                }
            }.padding()
            .task {
                newsViewModel.fetchLikes(article.url)
                newsViewModel.fetchComments(article.url)
            }
        }
    }
}

