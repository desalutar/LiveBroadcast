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
                        .padding(.bottom, 10)
                    PostGridView()
                        .tint(.white)
                }.padding(.top)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
        .tint(.orange)
    }
}

#Preview {
    CurrentUserProfileView()
}
