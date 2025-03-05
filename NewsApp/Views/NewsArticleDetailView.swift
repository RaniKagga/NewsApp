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
            Group {
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
                    Text("\(article.publishedAt)")
                        .foregroundStyle(.gray)
                    
                    HStack(spacing: 20) {
                        Spacer()
                        HStack {
                            VStack {
                                Image(systemName: "hand.thumbsup.fill")
                                Text("Likes")
                            }
                            Text("\(newsViewModel.likesCount)")
                        }
                        Spacer()
                        HStack {
                            VStack {
                                Image(systemName: "ellipsis.message")
                                Text("Comments")
                            }
                            Text("\(newsViewModel.commentsCount)")
                        }
                        Spacer()
                    }
                }
                
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
                    Spacer()
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
                }
            }.padding()
            .onAppear {
                newsViewModel.fetchLikes(article.url)
                newsViewModel.fetchComments(article.url)
            }
        }.navigationTitle("News Article Detail")
    }
}

#Preview {
    NewsArticleDetailView(article: NewsArticle(source: Source(id: "", name: "The Journal"), author: "", title: "Case Study", description: "This journal is about case study", url: "", urlToImage: nil, publishedAt: "", content: nil))
}
