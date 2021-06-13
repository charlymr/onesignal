//
//  OneSignalLocalContent.swift
//  OneSignal
//
//  Created by Denis Martin-Bruillot on 13/06/2021.
//

import Foundation

public struct OneSignalLocalContent {
    
    public typealias Language = OneSignalLanguage

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

extension OneSignalLocalContent: Encodable, Decodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        var coded = [String: String]()
        for message in messages {
            coded[message.key.rawValue] = message.value
        }
        try container.encode(coded)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let values = try container.decode([String: String].self)
        var coded = [Language: String]()
        for value in values {
            if let lang = Language.init(rawValue: value.key) {
                coded[lang] = value.value
            }
        }
        self.messages = coded
    }

}
