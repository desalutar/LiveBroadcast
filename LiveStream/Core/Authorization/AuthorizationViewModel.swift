//
//  AuthorizationViewModel.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 15.07.24.
//

import SwiftUI
import Foundation

class AuthorizationViewModel: ObservableObject {
    @Published private var user: User?
    @Published private var userSessionManager: UserSessionManager?
    
    func authUser(username: String, password: String) async throws {
        
    }
}
