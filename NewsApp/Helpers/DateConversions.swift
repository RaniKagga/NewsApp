//
//  DateConversions.swift
//  NewsApp
//
//  Created by K Nagarani on 06/03/25.
//

import Foundation

func formatDate(_ isoDate: String) -> String {
    let formatter = ISO8601DateFormatter()
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    
    if let date = formatter.date(from: isoDate) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM d, yyyy"
        return outputFormatter.string(from: date)
    }
    
    return "Invalid date"
}
