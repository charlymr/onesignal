//
//  OneSignalNotification.swift
//  OneSignal
//
//  Created by Anthony Castelli on 9/5/18.
//

import Foundation

public struct OneSignalNotification {
    
    public enum Method {
        /**
         playersId: [String]
         RECOMMENDED - Specific players to send your notification to. Does not require API Auth Key.
         Do not combine with other targeting parameters. Not compatible with any other targeting parameters.
         
         Example: `["1dd608f2-c6a1-11e3-851d-000c2940e62c"]`
         
         iosDeviceTokens: [String]?
         NOT RECOMMENDED - Please consider using include_player_ids instead.
         Target using iOS device tokens. Warning: Only works with Production tokens.
         All non-alphanumeric characters must be removed from each token. If a token does not correspond
         to an existing user, a new user will be created.
         
         Example: `ce777617da7f548fe7a9ab6febb56cf39fba6d38203...`
         */
        static func withPlayers(_ playersId: [String], iosDeviceTokens: [String]? = nil) -> Method {
            return .players(playersId, iosDeviceTokens: iosDeviceTokens)
        }
        case players(_ playersId: [String], iosDeviceTokens: [String]?)

        /**
         included: [String]
         The segment names you want to target.
         Users in these segments will receive a notification.
         This targeting parameter is only compatible with excluded_segments.
 
         Example: ["Active Users", "Inactive Users"]
         
         excluded: [String]?
         Segment that will be excluded when sending.
         Users in these segments will not receive a notification, even if they were included in included_segments.
         This targeting parameter is only compatible with included_segments.
         
         Example: ["Active Users", "Inactive Users"]
         */
        static func withSegments(_ included: [String], excluded: [String]? = nil) -> Method {
            return .segments(included, excluded: excluded)
        }
        case segments(_ included: [String], excluded: [String]?)

        /**
         "All" sergments
         All users in from all segments will receive a notification.
         This targeting parameter is only compatible with excluded_segments.
          
         excluded: [String]?
         Segment that will be excluded when sending.
         Users in these segments will not receive a notification, even if they were included in included_segments.
         This targeting parameter is only compatible with included_segments.
         
         Example: ["Active Users", "Inactive Users"]
         */
        static func withAllSegments(excluded: [String]? = nil) -> Method {
            return .segments(["All"], excluded: excluded)
        }

    }

    public typealias BadgeType = OneSignalIOSBadgeType

    public struct Config {
        /**
         Sound file that is included in your app to play instead of the default device notification sound.
         Pass nil to disable vibration and sound for the notification.

         Example: `"notification.wav"`
         */
        
        public let sound: String?
        /**
         Category APS payload, use with `registerUserNotificationSettings:categories` in your Objective-C / Swift code.

         Example: calendar category which contains actions like accept and decline
         iOS 10+ This will trigger your `UNNotificationContentExtension` whose ID matches this category.
         */
        public let category: String?
        
        /**
         Schedule notification for future delivery.

         Examples: All examples are the exact same date & time.
         `"Thu Sep 24 2015 14:00:00 GMT-0700 (PDT)"`
         `"September 24th 2015, 2:00:00 pm UTC-07:00"`
         `"2015-09-24 14:00:00 GMT-0700"`
         `"Sept 24 2015 14:00:00 GMT-0700"`
         `"Thu Sep 24 2015 14:00:00 GMT-0700 (Pacific Daylight Time)"`
         */
        public let sendAfter: String?
        /**
         Used with ``badgeType``, describes the value to set or amount to increase/decrease your app's iOS badge count by.
         You can use a negative number to decrease the badge count when used with an `badgeType` of Increase.
         */
        public let badge: Int?
        /**
         Describes whether to set or increase/decrease your app's iOS badge count by the`` badge`` specified count. Can specify `None`, `SetTo`, or `Increase`.
         `None` leaves the count unaffected.
         `SetTo` directly sets the badge count to the number specified in ios_badgeCount.
         `Increase` adds the number specified in ios_badgeCount to the total. Use a negative number to decrease the badge count.
         */
        public let badgeType: BadgeType?
        /**
         Add sing media attachments to notifications. Set as JSON object, key as a media id of your choice and the value as a valid local filename or URL. User must press and hold on the notification to view.
            
         Do not set `id` in `attachments` if you providing multiple attachment, doing will ignore the this value.

         Do not set `isContentMutable` to download attachments. The OneSignal SDK does this automatically.

         Example of updated: `{"id": "https://domain.com/image.jpg", "custom": "test"... }`
         */
        public let iOSImage: URL?
        
        /**
         (Android)
         Picture to display in the expanded view. Can be a drawable resource name or a URL.
         */
        public let droidImage: URL?
        
        /**
           Init
         */
        public init(sound: String? = nil,
             category: String? = nil,
             sendAfter: String? = nil,
             badge: Int? = nil,
             badgeType: BadgeType? = nil,
             iOSImage: URL? = nil,
             droidImage: URL? = nil) {
            self.sound = sound
            self.category = category
            self.sendAfter = sendAfter
            self.badge = badge
            self.badgeType = badgeType
            self.iOSImage = iOSImage
            self.droidImage = droidImage
        }
    }
    /**
     The notification's title, a map of language codes to text for each language. Each hash must have a language
     code string for a key, mapped to the localized text you would like users to receive for that language.
     This field supports inline substitutions.

     Example: `{"en": "English Title", "es": "Spanish Title"}`
     */
    public var title: OneSignalLocalContent?

    /**
     The notification's subtitle, a map of language codes to text for each language.
     Each hash must have a language code string for a key, mapped to the localized text you would like
     users to receive for that language.

     This field supports inline substitutions https://documentation.onesignal.com/docs/tag-variable-substitution.
     Example: `{"en": "English Message", "es": "Spanish Message"}`
     */
    public var subtitle: OneSignalLocalContent?

    /**
     REQUIRED unless content_available=true or template_id is set.

     The notification's content (excluding the title), a map of language codes to text for each language.

     Each hash must have a language code string for a key, mapped to the localized text you would like
     users to receive for that language.
     This field supports inline substitutions.
     English must be included in the hash.

     Example: `{"en": "English Message", "es": "Spanish Message"}`
     */
    public var message: OneSignalLocalContent

    /**
     Category APS payload, use with `registerUserNotificationSettings:categories` in your Objective-C / Swift code.

     Example: calendar category which contains actions like accept and decline
     iOS 10+ This will trigger your `UNNotificationContentExtension` whose ID matches this category.
     */
    public var category: String?

    /**
     Describes whether to set or increase/decrease your app's iOS badge count by the`` badge`` specified count. Can specify `None`, `SetTo`, or `Increase`.
     `None` leaves the count unaffected.
     `SetTo` directly sets the badge count to the number specified in ios_badgeCount.
     `Increase` adds the number specified in ios_badgeCount to the total. Use a negative number to decrease the badge count.
     */
    public var badgeType: BadgeType?

    /**
     Used with ``badgeType``, describes the value to set or amount to increase/decrease your app's iOS badge count by.
     You can use a negative number to decrease the badge count when used with an `badgeType` of Increase.
     */
    public var badge: Int?
    
    /**
     (Android)
     Picture to display in the expanded view. Can be a drawable resource name or a URL.
     */
    public var bigPicture: URL?
    
    /**
     Sound file that is included in your app to play instead of the default device notification sound.
     Pass nil to disable vibration and sound for the notification.

     Example: `"notification.wav"`
     */
    public var sound: String?

    /**
     Schedule notification for future delivery.

     Examples: All examples are the exact same date & time.
     `"Thu Sep 24 2015 14:00:00 GMT-0700 (PDT)"`
     `"September 24th 2015, 2:00:00 pm UTC-07:00"`
     `"2015-09-24 14:00:00 GMT-0700"`
     `"Sept 24 2015 14:00:00 GMT-0700"`
     `"Thu Sep 24 2015 14:00:00 GMT-0700 (Pacific Daylight Time)"`
     */
    public var sendAfter: String?

    /**
     A custom map of data that is passed back to your app.

     Example: `{"abc": "123", "foo": "bar"}`
     */
    public var additionalData: [String: String]?

    /**
     Adds media attachments to notifications. Set as JSON object, key as a media id of your choice and
     the value as a valid local filename or URL. User must press and hold on the notification to view.

     Do not set `mutable_content` to download attachments. The OneSignal SDK does this automatically
     */
    public var attachments: [String: String]?

    /**
     Sending true wakes your app from background to run custom native code
     (Apple interprets this as content-available=1).

     Note: Not applicable if the app is in the "force-quit" state (i.e app was swiped away).
     Omit the contents field to prevent displaying a visible notification.
     */
    public var isContentAvailable: Bool?

    /**
     Sending true allows you to change the notification content in your app before it is displayed.
     Triggers `didReceive(_:withContentHandler:)` on your `UNNotificationServiceExtension.`
     */
    public var isContentMutable: Bool?
    
    /**
     Init method
     */
    public init(title: OneSignalLocalContent? = nil,
                subtitle: OneSignalLocalContent? = nil,
                message: OneSignalLocalContent,
                config: Config? = nil,
                additionalData: [String : String]? = nil,
                attachments: [String : String]? = nil
        ) {
        
        self.title = title
        self.subtitle = subtitle
        self.message = message
        self.sound = config?.sound
        self.category = config?.category
        self.sendAfter = config?.sendAfter
        self.badge = config?.badge
        self.badgeType = config?.badgeType
        self.bigPicture = config?.droidImage
        self.additionalData = additionalData
        self.attachments = attachments
        if let imageURL = config?.iOSImage, self.attachments?["id"] == nil {
            if self.attachments == nil  {
                self.attachments = [String : String]()
            }
            self.attachments?["id"] = "\(imageURL)"
        }
    }
    
}

extension OneSignalNotification: Codable {
    
    enum CodingKeys: String, CodingKey {
        case title
        case subtitle
        case message

        case category = "ios_category"
        
        case sound = "ios_sound"
        case badge = "ios_badgeCount"
        case badgeType = "ios_badgeType"
        case sendAfter = "send_after"
        case additionalData = "data"
        case attachments = "ios_attachments"

        case isContentAvailable = "content_available"
        case isContentMutable = "mutable_content"
        
        case bigPicture = "big_picture"
    }
    
}

