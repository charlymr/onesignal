//
//  OneSignal.swift
//  OneSignal
//
//  Created by Anthony Castelli on 9/5/18.
//

import Foundation

public final class OneSignal {
    
    /// `URLSession``used to perform request
    public let session: URLSession
    
    /// Initialisation method
    /// - Parameter session: An optional ``URLSession`` to use
    public init(session: URLSession = URLSession.init(configuration: URLSessionConfiguration.default)) {
        self.session = session
    }

    /// Send the message to OneSignal
    /// - Parameters:
    ///   - notification: ``OneSignalNotification`` to send
    ///   - app: The ``OneSignalApp`` containing API Key/ API token
    ///   - target: Notification target. See ``OneSignalNotification.Method``
    ///   - autoStart: Default to true, will automatically start the ``URLSessionDataTask``
    ///   - completion: returning ``OneSignalResult`` & response ``Data?`` if any
    /// - Returns: ``URLSessionDataTask`` if  we could create the task
    @discardableResult
    public func send(notification: OneSignalNotification,
                     toApp app: OneSignalApp,
                     target: OneSignalNotification.Method,
                     autoStart: Bool = true,
                     completion: @escaping (OneSignalResult, Data?) -> Void) -> URLSessionDataTask? {
        do {
            
            let request = try notification.generateRequest(for: app, method: target)
            
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
            if autoStart {
                task.resume()
            }
            return task
            
        } catch let error as OneSignalError {
            completion(OneSignalResult.error(error: error), nil)
            
        } catch {
            completion(OneSignalResult.error(error: OneSignalError.internal), nil)
        }
        return nil
    }

}
