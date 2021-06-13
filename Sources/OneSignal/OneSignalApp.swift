//
//  OneSignalApp.swift
//  OneSignal
//
//  Created by Anthony Castelli on 9/5/18.
//

import Foundation

public struct OneSignalApp: Codable {
        
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case appId = "app_id"
    }

    public let url = URL(string: "https://onesignal.com/api/v1/notifications")!
    public let apiKey: String
    public let appId: String

    /**
     Init method
     - See: https://documentation.onesignal.com/reference/create-notification
     - Parameters:
     - apiKey: OneSignal API Key
     - appId:  OneSignal APP  ID
     */
    public init(apiKey: String, appId: String) {
        self.apiKey = apiKey
        self.appId = appId
    }
}
