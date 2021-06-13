//
//  File.swift
//  
//
//  Created by Denis Martin-Bruillot on 13/06/2021.
//

import Foundation

extension OneSignalNotification {
    
    internal func generateRequest(for app: OneSignalApp, method: Method) throws -> URLRequest {
        var request = URLRequest(url: app.url)
        request.httpMethod = "POST"
        
        request.addValue("Keep-Alive", forHTTPHeaderField: "Connection")
        request.addValue("Basic \(app.apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let playerIds: [String]?
        let iosDeviceTokens: [String]?
        let segments: [String]?
        let excludedSegments: [String]?

        switch method {
        case let .players(ids, tokens):
            playerIds = ids
            iosDeviceTokens = tokens
            segments = nil
            excludedSegments = nil
        case let .segments(included, excluded):
            segments = included
            excludedSegments = excluded
            playerIds = nil
            iosDeviceTokens = nil
        }

        let payload = OneSignalPayload(
            appId: app.appId,
            playerIds: playerIds,
            iosDeviceTokens: iosDeviceTokens,
            segments: segments,
            excludedSegments: excludedSegments,
            contents: message,
            headings: title,
            subtitle: subtitle,
            category: category,
            badge: badge,
            badgeType: badgeType,
            sound: sound,
            sendAfter: sendAfter,
            additionalData: additionalData,
            attachments: attachments,
            bigPicture: bigPicture,
            contentAvailable: isContentAvailable,
            mutableContent: isContentMutable
        )

        do {
            request.httpBody = try JSONEncoder().encode(payload)
            
        } catch {
            throw OneSignalError.makeRequestBodyFailed(error)
        }

        return request
    }

}
