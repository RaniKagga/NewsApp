//
//  BookmarksViewModel.swift
//  NewsApp
//
//  Created by K Nagarani on 06/03/25.
//

import Foundation
import SwiftUI

class BookmarksViewModel: ObservableObject {
    @Published var bookmarks: [NewsArticle] = []
    
    func addBookmark(_ article: NewsArticle) {
        bookmarks.append(article)
        storeBookmarks()
    }
    
    func removeBookmark(_ article: NewsArticle) {
        bookmarks.removeAll(where: {$0 == article})
        storeBookmarks()
    }
    
    func isBookmarked(_ article: NewsArticle) -> Bool {
        bookmarks.contains(where: {$0 == article})
    }
    
    func clearBookmarks() {
        bookmarks.removeAll()
        storeBookmarks()
    }
    
    func loadBookmarks() {
        if let savedBookmarks = OfflineStorageManager.shared.getOfflineData(forKey: "bookmarks") {
            do {
                bookmarks = try JSONDecoder().decode([NewsArticle].self, from: savedBookmarks)
            } catch {
                print("Error loading bookmarks: \(error)")
            }
        }
    }
    
    func storeBookmarks() {
        do {
            let savedData = try JSONEncoder().encode(bookmarks)
            OfflineStorageManager.shared.saveOfflineData(savedData, forKey: "bookmarks")
        } catch {
            print("Error saving bookmarks: \(error)")
        }
    }
}
