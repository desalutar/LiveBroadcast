//
//  LiveStreamApp.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 24.05.24.
//

import SwiftUI

@main
struct LiveStreamApp: App {
    let selectedUser = UserSessionManager()
    var body: some Scene {
        WindowGroup {
//            AuthorizationView().environmentObject(selectedUser)
            MainTabView().environmentObject(selectedUser)
        }
    }
}
