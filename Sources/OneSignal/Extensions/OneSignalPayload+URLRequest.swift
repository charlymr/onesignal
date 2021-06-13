//
//  File.swift
//  
//
//  Created by Denis Martin-Bruillot on 13/06/2021.
//

import Foundation

public extension OneSignalPayload {
    
    static func from(_ request: URLRequest) throws -> OneSignalPayload {
        guard let httpBody = request.httpBody else {
            throw OneSignalError.internal
        }
        return try JSONDecoder().decode(OneSignalPayload.self, from: httpBody)
    }
}
