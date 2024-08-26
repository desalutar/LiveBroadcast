//
//  ProfileHeaderView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 24.05.24.
//

import SwiftUI
import PhotosUI

struct ProfileHeaderView: View {
    @EnvironmentObject var appState: UserSessionManager
    @StateObject var viewModel = ProfileViewModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HStack {
                    notificationsButton
                    profilePhoto
                    settingsButton
                }
                fullName
                userStats
                Divider()
            }
        }
    }
    
    var notificationsButton: some View {
        NavigationLink(destination: NotificationsView()) {
            Image(systemName: "bell.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(.orange)
        }
        .padding(.trailing, 45)
    }
    
    var profilePhoto: some View {
        PhotosPicker(selection: $viewModel.selectedImage) {
            if let image = viewModel.profileImage {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundStyle(Color(.systemGray4))
            }
        }
    }
    
    var settingsButton: some View {
        NavigationLink(destination: UserProfileSettingsView()){
            Image(systemName: "slider.vertical.3")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(.orange)
        }
        .padding(.leading, 45)
    }
    
    var fullName: some View {
        Text(appState.selectedUser.first?.name ?? "not a name")
            .font(.title2)
            .fontWeight(.bold)
    }
    
    var userStats: some View {
        NavigationStack {
            HStack(spacing: 20) {
                viewModel.userStatNavigationLink(destination: FollowingView(), value: appState.selectedUser.first?.userStats?.followingCount ?? "0", title: "Following")
                viewModel.userStatNavigationLink(destination: LikedByUsersView(), value: appState.selectedUser.first?.userStats?.likesCount ?? "0", title: "Likes")
                viewModel.userStatNavigationLink(destination: SubscribersView(), value: appState.selectedUser.first?.userStats?.followersCount ?? "0", title: "Subscribers")
            }
        }
    }
}

#Preview {
    ProfileHeaderView()
}
