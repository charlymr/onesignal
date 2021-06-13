//
//  OneSignalPayload.swift
//  OneSignal
//
//  Created by Anthony Castelli on 9/5/18.
//

import Foundation

public struct OneSignalPayload {
    
    public typealias Language = OneSignalLanguage
    public typealias BadgeType = OneSignalIOSBadgeType
    
    public var appId: String
    
    public var playerIds: [String]?
    public var iosDeviceTokens: [String]?
    public var segments: [String]?
    public var excludedSegments: [String]?
    
    public var contents: OneSignalLocalContent
    public var headings: OneSignalLocalContent?
    public var subtitle: OneSignalLocalContent?

    public var category: String?
    public var badge: Int?
    public var badgeType: BadgeType?
    public var sound: String?
    public var sendAfter: String?
    public var additionalData: [String: String]?
    public var attachments: [String: String]?
    public var imageURL: URL?
    public var bigPicture: URL?

    public var contentAvailable: Bool?
    public var mutableContent: Bool?
}

extension OneSignalPayload: Codable {
    
    enum CodingKeys: String, CodingKey {
        case appId = "app_id"
        case playerIds = "include_player_ids"
        case iosDeviceTokens = "include_ios_tokens"
        case segments = "included_segments"
        case excludedSegments = "excluded_segments"

        case contents
        case headings
        case subtitle

        case category = "ios_category"
        
        case sound = "ios_sound"
        case badge = "ios_badgeCount"
        case badgeType = "ios_badgeType"
        case sendAfter = "send_after"
        case additionalData = "data"
        case attachments = "ios_attachments"

        case contentAvailable = "content_available"
        case mutableContent = "mutable_content"
        
        case imageURL = "image_url"
        case bigPicture = "big_picture"

    }

}
