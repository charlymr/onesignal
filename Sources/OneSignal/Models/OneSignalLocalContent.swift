//
//  OneSignalLocalContent.swift
//  OneSignal
//
//  Created by Denis Martin-Bruillot on 13/06/2021.
//

import Foundation

public struct OneSignalLocalContent: Codable {
    
    public typealias Language = OneSignalLanguage
    
    public var onesignalmessages: [Language: String] {
        messages
    }
    
    internal var messages: [Language: String]

    public init(_ message: String, localMessage: [Language: String]? = nil) {
        // English is required by `OneSignal`
        self.messages = [ .english: message ]
        if let localMessage = localMessage {
            for local in localMessage {
                self.messages[local.key] = local.value
            }
        }
    }

    public subscript(key: Language) -> String? {
        get {
            return self.messages[key]
        }
        set {
            self.messages[key] = newValue
        }
    }
}

