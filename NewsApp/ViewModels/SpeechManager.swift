//
//  SpeechManager.swift
//  NewsApp
//
//  Created by K Nagarani on 06/03/25.
//

import Foundation
import Speech
import Combine
import SwiftUI

class SpeechManager {
    static let shared = SpeechManager()
    private let synthesizer = AVSpeechSynthesizer()
    
    private init() {}
    
    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(identifier: "en-US")
        synthesizer.speak(utterance)
    }
}
