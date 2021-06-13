//
//  OneSignalResult.swift
//  OneSignal
//
//  Created by Anthony Castelli on 9/5/18.
//

import Foundation

public enum OneSignalError: Swift.Error {
    case `internal`
    case invalidURL
    case makeRequestBodyFailed(Error)
    case makeRequestFailed(Error)
    case apiKeyNotSet
    case appIDNotSet
    case requestError(value: String)
    case decodingError
}

public enum OneSignalResult {
    case success
    case error(error: OneSignalError)
    case networkError(error: Error)
}
