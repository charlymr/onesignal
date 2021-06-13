@testable import OneSignal
import XCTest

final class OneSignalTests: XCTestCase {
    
    private func defaultNotification() -> OneSignalNotification {
        OneSignalNotification(
            title: nil,
            subtitle: nil,
            message: .init("Hello Message"),
            config: .init(sound: nil,
                          category: nil,
                          sendAfter: nil,
                          badge: nil,
                          badgeType: nil,
                          iOSImage: nil,
                          droidImage: nil),
            additionalData: nil,
            attachments: nil
        )
    }
    
    func testHeaders() throws {
        let notification = defaultNotification()
        let request = try notification.generateRequest(for: .init(apiKey: "AnAPIKeyHere",
                                                                  appId: "AnAPPIDHere"),
                                                       method: .withAllSegments())
        XCTAssertEqual(request.url?.absoluteString, "https://onesignal.com/api/v1/notifications")
        XCTAssertEqual(request.allHTTPHeaderFields?["Authorization"], "Basic AnAPIKeyHere")
        XCTAssertEqual(request.allHTTPHeaderFields?["Content-Type"], "application/json")
        
    }
    
    func testGenerateRequestWithAllSegments() throws {
        let notification = defaultNotification()
        let request = try notification.generateRequest(for: .init(apiKey: "AnAPIKeyHere",
                                                                  appId: "AnAPPIDHere"),
                                                       method: .withAllSegments())
        
        XCTAssertEqual(try OneSignalPayload.from(request).segments?.first, "All")
        XCTAssertEqual(request.httpBody?.count, #"{"contents":{"en":"Hello Message"},"app_id":"AnAPPIDHere","included_segments":["All"]}"# .count)
        
    }
    
    func testGenerateRequestWithPlayersID() throws {
        let notification = defaultNotification()
        let request = try notification.generateRequest(for: .init(apiKey: "AnAPIKeyHere",
                                                                  appId: "AnAPPIDHere"),
                                                       method: .withPlayers(["foo...", "bar..."]))
        
        XCTAssertEqual(request.httpBody?.count, #"{"contents":{"en":"Hello Message"},"app_id":"AnAPPIDHere","include_player_ids":["foo...","bar..."]}"# .count)
        
    }
    
    func testIOSImagesNoAttachmments() throws {
        let notification = OneSignalNotification(
            message: .init("Hello Message"),
            config: .init(sound: nil,
                          category: nil,
                          sendAfter: nil,
                          badge: nil,
                          badgeType: nil,
                          iOSImage: URL(string: "https://www.apple.com/hero.jpg")!,
                          droidImage: nil),
            additionalData: nil,
            attachments: nil
        )
        let request = try notification.generateRequest(for: .init(apiKey: "AnAPIKeyHere",
                                                                  appId: "AnAPPIDHere"),
                                                       method: .withAllSegments())
        
        XCTAssertEqual(try OneSignalPayload.from(request).attachments?["id"], "https://www.apple.com/hero.jpg")
        
    }
    
    func testIOSImagesWithNonClashingAttachmments() throws {
        let notification = OneSignalNotification(
            message: .init("Hello Message"),
            config: .init(sound: nil,
                          category: nil,
                          sendAfter: nil,
                          badge: nil,
                          badgeType: nil,
                          iOSImage: URL(string: "https://www.apple.com/hero.jpg")!,
                          droidImage: nil),
            additionalData: nil,
            attachments: [ "customID" : "https://www.apple.com/hero2.jpg" ]
        )
        let request = try notification.generateRequest(for: .init(apiKey: "AnAPIKeyHere",
                                                                  appId: "AnAPPIDHere"),
                                                       method: .withAllSegments())
        
        XCTAssertEqual(try OneSignalPayload.from(request).attachments?["id"], "https://www.apple.com/hero.jpg")
        
    }
    
    func testIOSImagesWithClashingAttachmments() throws {
        let notification = OneSignalNotification(
            message: .init("Hello Message"),
            config: .init(sound: nil,
                          category: nil,
                          sendAfter: nil,
                          badge: nil,
                          badgeType: nil,
                          iOSImage: URL(string: "https://www.apple.com/hero.jpg")!,
                          droidImage: URL(string: "https://www.apple.com/hero2.jpg")!),
            additionalData: nil,
            attachments: [ "id" : "https://www.apple.com/hero2.jpg" ]
        )
        let request = try notification.generateRequest(for: .init(apiKey: "AnAPIKeyHere",
                                                                  appId: "AnAPPIDHere"),
                                                       method: .withAllSegments())
        
        XCTAssertEqual(try OneSignalPayload.from(request).attachments?["id"], "https://www.apple.com/hero2.jpg")
        
        XCTAssertNotNil(try OneSignalPayload.from(request).bigPicture)
        
        XCTAssertEqual("\(try OneSignalPayload.from(request).bigPicture!)", "https://www.apple.com/hero2.jpg")

    }
    
}
