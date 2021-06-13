//
//  OneSignal.swift
//  OneSignal
//
//  Created by Anthony Castelli on 9/5/18.
//

import Foundation

public final class OneSignal {
    
    public let session: URLSession

    public init(session: URLSession = URLSession.init(configuration: URLSessionConfiguration.default)) {
        self.session = session
    }

    /// Send the message to OneSignal
    public func send(notification: OneSignalNotification,
                     toApp app: OneSignalApp,
                     method: OneSignalNotification.Method,
                     completion: @escaping (OneSignalResult, Data?) -> Void) {
        do {
            
            let request = try notification.generateRequest(for: app, method: method)
            
            let task = session.dataTask(with: request) { data, response, error in
                
                guard let body = data, let response = response as? HTTPURLResponse else {
                    completion(OneSignalResult.error(error: OneSignalError.internal), nil)
                    return
                }
                if let error = error {
                    completion(OneSignalResult.networkError(error: error), nil)
                    return
                }
                guard response.statusCode == 200 else {
                    completion(OneSignalResult.error(error: OneSignalError.internal), nil)
                    return
                }
                completion(.success, body)
            }
            task.resume()
            
        } catch let error as OneSignalError {
            completion(OneSignalResult.error(error: error), nil)
            
        } catch {
            completion(OneSignalResult.error(error: OneSignalError.internal), nil)
        }
        
    }

}
