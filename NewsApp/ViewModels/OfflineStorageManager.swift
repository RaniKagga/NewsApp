//
//  OfflineStorageManager.swift
//  NewsApp
//
//  Created by K Nagarani on 06/03/25.
//

import Foundation

class OfflineStorageManager {
    static let shared = OfflineStorageManager()
    
    private init() {}
    
    func saveOfflineData(_ data: Data, forKey key: String) {
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func getOfflineData(forKey key: String) -> Data? {
        return UserDefaults.standard.object(forKey: key) as? Data
    }
}
