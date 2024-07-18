//
//  AuthNetworkService.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 17.07.24.
//

import Foundation

class AuthNetworkService {
    static let shared = AuthNetworkService()
    private init() {}
    
    private let localhost = "http://127.0.0.1:8080"
    
    func auth(username: String, password: String) async throws -> User {
        let userRequestBody = UserRequestBody(username: username, password: password)
        guard let url = URL(string: "\(localhost)\(ApiMethod.auth.rawValue)") else {
            throw NetworkErrors.dabURL
        }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let encoderData = try JSONEncoder().encode(userRequestBody)
        request.httpBody = encoderData
        
        let (data, userResponse) = try await URLSession.shared.data(for: request)
        
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
