//
//  AuthNetworkService.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 17.07.24.
//

import Foundation
import Security

struct UserRequestBody: Codable {
    var username: String
    var password: String
    var name: String?
    var lastName: String?
}

enum ApiMethod: String {
    case authUser = "/users/authUser"
    case createUser = "/users/createUser"
}

class AuthRegistrationNetworkService {
    static let shared = AuthRegistrationNetworkService()
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
    
    func performRequest(_ method: ApiMethod, with username: String, _ password: String,
                        _ name: String? = nil, _ lastName: String? = nil) async throws -> User {
        guard let url = URL(string: "\(HostName.init().host)\(method.rawValue)") else {
            throw NetworkErrors.invalidURL
        }
        
        let userRequestBody: UserRequestBody
        switch method {
        case .authUser:
            userRequestBody = UserRequestBody(username: username,
                                              password: password)
        case .createUser:
            guard let name = name,
                  let lastName = lastName else {
                throw NetworkErrors.invalidRequest
            }
            userRequestBody = UserRequestBody(username: username, password: password, 
                                              name: name , lastName: lastName)
        }
        
        let request = try createRequest(from: userRequestBody, url: url)
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, 
                                 delegate: URLSessionPinningDelegate(),
                                 delegateQueue: nil)
        
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
