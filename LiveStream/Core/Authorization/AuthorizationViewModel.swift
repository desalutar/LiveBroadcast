//
//  AuthorizationViewModel.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 15.07.24.
//

import SwiftUI
import Foundation

class AuthorizationViewModel: ObservableObject {
    @EnvironmentObject var appState: UserSessionManager
    @Published var isAuth = true
    @Published var isShowMapView = false
    @Published var error: Error?
    
    @Published var name = ""
    @Published var lastName = ""
    @Published var username = ""
    @Published var password = ""
    @Published var confirmPassword = ""

    let networkService = AuthRegistrationNetworkService.shared
    
    func authenticationUser(with username: String, _ password: String,
                      _ name: String? = nil, _ lastName: String? = nil) async throws -> User {
        if let name = name,
           let lastName = lastName {
            return try await networkService.performRequest(.createUser, with: username,
                                                                password, name, lastName)
        } else {
            return try await networkService.performRequest(.authUser, with: username, password)
        }
    }
}
