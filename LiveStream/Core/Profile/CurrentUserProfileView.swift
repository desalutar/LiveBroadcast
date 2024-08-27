//
//  CurrentUserProfileView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 24.05.24.
//

import SwiftUI

struct CurrentUserProfileView: View {
    @EnvironmentObject var appState: UserSessionManager
    @State private var progress: Double = 0.5
    var userMediaItem = UserMediaItem(id: "0", userPhoto: "123")
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 2) {
                    ProfileHeaderView()
                    ForEach(0..<5) {_ in
                        UserMediaItemView(item: userMediaItem)
                    }
                }.padding(.top)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
        .tint(.orange)
    }
}

struct CurrentUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let appState = UserSessionManager()
        return CurrentUserProfileView()
            .environmentObject(appState)
    }
}
