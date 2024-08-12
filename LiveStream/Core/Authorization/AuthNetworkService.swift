//
//  AuthNetworkService.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 17.07.24.
//

import Foundation
import Security

struct UserRequestBody: Encodable {
    let username: String
    var password: String
}

enum ApiMethod: String {
    case auth = "/users/auth"
}

enum NetworkErrors: Error, LocalizedError {
    case invalidURL
    case serverError(statusCode: Int)
    case encodingError(String)
    case decodingError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .serverError(let statusCode):
            return "Server error with status code \(statusCode)"
        case .encodingError(let message):
                   return "Error encoding request: \(message)"
        case .decodingError(let message):
            return "Error decoding response: \(message)"
        }
    }
}

class AuthNetworkService {
    static let shared = AuthNetworkService()
    private init() {}
    private let host = HostName.init().host
    
    func createRequest(from requestBody: Encodable, url: URL) throws -> URLRequest {
        do {
            var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let encoder = try JSONEncoder().encode(requestBody)
            request.httpBody = encoder
            
            return request
        } catch {
            throw NetworkErrors.encodingError(error.localizedDescription)
        }
    }
    
    func auth(username: String, password: String) async throws -> User {
        guard let url = URL(string: "\(HostName.init().host)\(ApiMethod.auth.rawValue)") else {
            throw NetworkErrors.invalidURL
        }
        
        let userRequestBody = UserRequestBody(username: username, password: password)
        let request = try createRequest(from: userRequestBody, url: url)
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration, delegate: URLSessionPinningDelegate(), delegateQueue: nil)
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkErrors.serverError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
        }
        
        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            return user
        } catch {
            throw NetworkErrors.decodingError(error.localizedDescription)
        }
    }
}


