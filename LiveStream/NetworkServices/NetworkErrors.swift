//
//  NetworkErrors.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 12.08.24.
//

import Foundation

enum NetworkErrors: Error, LocalizedError {
    case invalidURL
    case invalidRequest
    case serverError(statusCode: Int)
    case encodingError(String)
    case decodingError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidRequest:
            return "Invalid request"
        case .serverError(let statusCode):
            return "Server error with status code \(statusCode)"
        case .encodingError(let message):
                   return "Error encoding request: \(message)"
        case .decodingError(let message):
            return "Error decoding response: \(message)"
        }
    }
}
