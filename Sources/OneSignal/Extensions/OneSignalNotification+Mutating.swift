//
//  File.swift
//  
//
//  Created by Denis Martin-Bruillot on 13/06/2021.
//

import Foundation

public extension OneSignalNotification {
    
    mutating func setMessage(_ message: String, language: OneSignalLanguage = .english) {
        self.message[language] = message
    }
    
    mutating func setTitle(_ title: String, language: OneSignalLanguage = .english) {
        if self.title == nil {
            self.title = OneSignalLocalContent(title)
        }
        self.title?[language] = title
    }

    mutating func setTitle(_ message: OneSignalLocalContent) {
        self.title = message
    }

    mutating func setSubtitle(_ subtitle: String, language: OneSignalLanguage = .english) {
        if self.subtitle == nil {
            self.subtitle = OneSignalLocalContent(subtitle)
        }
        self.subtitle?[language] = subtitle
    }

    mutating func setSubtitle(_ message: OneSignalLocalContent) {
        self.subtitle = message
    }

    mutating func setContentAvailable(_ isContentAvailable: Bool?) {
        self.isContentAvailable = isContentAvailable
    }

    mutating func setContentMutability(_ isContentMutable: Bool?) {
        self.isContentMutable = isContentMutable
    }

}
