//
//  URLSession.swift
//  
//
//  Created by Denis Martin-Bruillot on 13/06/2021.
//

import Foundation

internal extension URLSession {
    
    struct Result {
        let data: Data?
        let response: URLResponse?
        let error: Error?
        let timeout: Bool
    }
    
    func syncRequest(with request: URLRequest, timeoutSeconds: Int = 30) -> Result {
        var returnedData: Data?
        var returnedResponse: URLResponse?
        var returnedError: Error?

        let dispatchGroup = DispatchGroup()
        let task = dataTask(with: request) { data, response, error in
            returnedData = data
            returnedResponse = response
            returnedError = error
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        task.resume()
        let result = dispatchGroup.wait(timeout: .now() + .seconds(timeoutSeconds))
        if result == .timedOut {
            return Result(data: returnedData, response: returnedResponse, error: returnedError, timeout: true)
        }
        return Result(data: returnedData, response: returnedResponse, error: returnedError, timeout: false)
    }
    
}
