//
//  ProfileHeaderView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 24.05.24.
//

import SwiftUI

struct ProfileHeaderView: View {
    @StateObject var viewModel = UserProfileViewModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HStack {
                    userNotifications
                    userProfilePhoto
                    userSettings
                }
                userFullNameView
                userStats
                Divider()
            }
        }
    }
    
    var userNotifications: some View {
        NavigationLink(destination: NotificationsView()) {
            Image(systemName: "bell.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(.orange)
        }
        .padding(.trailing, 45)
    }
    
    var userProfilePhoto: some View {
        Image(systemName: "person.circle.fill")
            .resizable()
            .frame(width: 80, height: 80)
            .foregroundStyle(Color(.systemGray4))
    }
    
    var userSettings: some View {
        NavigationLink(destination: UserProfileSettingsView()){
            Image(systemName: "slider.vertical.3")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(.orange)
        }
        .padding(.leading, 45)
    }
    
    var userFullNameView: some View {
        Text("name lastname")
            .font(.title2)
            .fontWeight(.bold)
    }
    
    var userStats: some View {
        NavigationStack {
            HStack(spacing: 20) {
                viewModel.userStatNavigationLink(destination: UserFollowingView(), value: 10, title: "Following")
                viewModel.userStatNavigationLink(destination: UserLikesView(), value: 500, title: "Likes")
                viewModel.userStatNavigationLink(destination: UserFollowersView(), value: 10203, title: "Followers")
            }
        }
    }
}

#Preview {
    ProfileHeaderView()
}
