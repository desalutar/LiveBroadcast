//
//  AuthorizationViewModel.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 15.07.24.
//

import SwiftUI
import Foundation
import Combine

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
    
    @Published var isLoginLengthValid = false
    @Published var isPasswordLengthValid = false
    @Published var isPasswordCapitalLetter = false
    @Published var isPasswordConfirmValid = false
    
    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        $username
            .receive(on: RunLoop.main)
            .map { username in
                return username.count >= 4
            }
            .assign(to: \.isLoginLengthValid, on: self)
            .store(in: &cancellableSet)
        $password
            .receive(on: RunLoop.main)
            .map { password in
                return password.count >= 8
            }
            .assign(to: \.isPasswordLengthValid, on: self)
            .store(in: &cancellableSet)
        $password
            .receive(on: RunLoop.main)
            .map { password in
                let pattern = "[A-Z]"
                if let _ = password.range(of: pattern, options: .regularExpression) {
                    return true
                } else {
                    return false
                }
            }
            .assign(to: \.isPasswordCapitalLetter, on: self)
            .store(in: &cancellableSet)
        Publishers.CombineLatest($password, $confirmPassword)
            .receive(on: RunLoop.main)
            .map { password, confirmPassword in
                return !confirmPassword.isEmpty && confirmPassword == password
            }
            .assign(to: \.isPasswordConfirmValid, on: self)
            .store(in: &cancellableSet)
    }
    
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
