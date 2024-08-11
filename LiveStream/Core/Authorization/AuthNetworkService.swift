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

enum NetworkErrors: Error {
    case dabURL
    case serverError(statusCode: Int)
    case decodingError
}

class AuthNetworkService {
    static let shared = AuthNetworkService()
    private init() {}
    private let host = HostName.init().host
    
    func auth(username: String, password: String) async throws -> User {
        let userRequestBody = UserRequestBody(username: username, password: password)
        guard let url = URL(string: "\(host)\(ApiMethod.auth.rawValue)") else {
            throw NetworkErrors.dabURL
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration, delegate: URLSessionPinningDelegate(), delegateQueue: nil)
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let encoderData = try JSONEncoder().encode(userRequestBody)
        request.httpBody = encoderData
        
        let (data, userResponse) = try await session.data(for: request)
        
        if let httpResponse = userResponse as? HTTPURLResponse {
            print("Статус-код ответа: \(httpResponse.statusCode)")
            if httpResponse.statusCode != 200 {
                throw NetworkErrors.serverError(statusCode: httpResponse.statusCode)
            }
        }
        
        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: data)
            return user
        } catch {
            print("Ошибка декодирования: \(error)")
            throw NetworkErrors.decodingError
        }
    }
}


