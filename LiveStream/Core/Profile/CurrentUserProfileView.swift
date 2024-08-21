//
//  CurrentUserProfileView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 24.05.24.
//

import SwiftUI

struct CurrentUserProfileView: View {
    @EnvironmentObject var appState: UserSessionManager
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 2) {
                    ProfileHeaderView()
                    PostGridView()
                }
                .padding(.top)
            }
            .navigationTitle(appState.selectedUser.first?.username ?? "profile")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

#Preview {
    CurrentUserProfileView()
}
