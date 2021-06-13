# OneSignal

## Example


```swift
let apiKey = "YourApiKey"
let appId = "YourAppId"
let notif = OneSignalNotification(
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

let app = OneSignalApp(apiKey: apiKey, appId: appId)
OneSignal().send(notification: notif,
                        toApp: app,
                        target: .withAllSegments()) { result, _ in
        print(result)
}
```

## Available Targets:

### PlayersID
```swift
withPlayers(_ playersId: [String], iosDeviceTokens: [String]? = nil)
```

#### RECOMMENDED 
`playersId: [String]`
- Specific players to send your notification to. Does not require API Auth Key.
Do not combine with other targeting parameters. Not compatible with any other targeting parameters.

Example: `["1dd608f2-c6a1-11e3-851d-000c2940e62c"]`

#### NOT RECOMMENDED 
`iosDeviceTokens: [String]?`
- Please consider using include_player_ids instead.
Target using iOS device tokens. Warning: Only works with Production tokens.
All non-alphanumeric characters must be removed from each token. If a token does not correspond
to an existing user, a new user will be created.

Example: `ce777617da7f548fe7a9ab6febb56cf39fba6d38203...`


## Segments

```swift
withSegments(_ included: [String], excluded: [String]? = nil) 
```

```swift
withAllSegments(excluded: [String]? = nil)
```

#### `included: [String]`
- The segment names you want to target.
Users in these segments will receive a notification.
This targeting parameter is only compatible with excluded_segments.

Example: `["Active Users", "Inactive Users"]`

#### `excluded: [String]?`
- Segment that will be excluded when sending.
Users in these segments will not receive a notification, even if they were included in included_segments.
This targeting parameter is only compatible with included_segments.

Example: `["Active Users", "Inactive Users"]`
