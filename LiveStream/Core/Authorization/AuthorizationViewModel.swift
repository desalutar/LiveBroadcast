//
//  AuthorizationViewModel.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 15.07.24.
//

import SwiftUI
import Foundation

//struct AuthParams {
//    let username: String
//    let password: String
//    let name: String?
//    let lastName: String?
//}

class AuthorizationViewModel: ObservableObject {
    @EnvironmentObject var appState: UserSessionManager
    @Published var isAuth = true
    @Published var user: User?
    @Published var error: Error?
    
    let networkService = AuthRegistrationNetworkService.shared
    
    func createUser(by username: String, _ password: String, 
                  _ name: String, _ lastName: String) async throws -> User {
        try await networkService.performRequest(.create, username: username, password: password,
                                                name: name, lastName: lastName)
    }
    
    func authenticate(by username: String, and password: String) async throws -> User {
        try await networkService.performRequest(.auth, username: username, password: password)
    }
}
