//
//  UserDetailsView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 27.06.24.
//

import SwiftUI

struct UserDetailsView: View {
    @EnvironmentObject var selectedUser: UserSessionManager
    @Binding var users: Users?
    @Binding var showingSheet: Bool
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        ScrollView {
            VStack {
                userInfoItem
                openUserBroadcast
                userStatView
                DetailUsersPostGridView()
            }
            .padding(.top, 30)
            .onAppear {
                locationManager.fetchLocationName(for:
                                                    users?.coordinate ?? .moscowCity)
            }
        }
        .scrollIndicators(.hidden)
    }
    
    var userInfoItem: some View {
        HStack {
            Image(systemName: "person")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.leading, 30)
            
            VStack(alignment: .listRowSeparatorLeading) {
                Text(users?.name ?? "Ishkhan")
                    .font(.headline)
                
                Text(locationManager.locationName)
            }
            .padding(.leading, 20)
            Spacer()
        }
    }
    
    var openUserBroadcast: some View {
        Button {
            selectedUser.selectedTab = 1
            showingSheet = false
            if let user = users {
                selectedUser.selectedUser.append(user)
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.orange)
                    .frame(width: 350, height: 52)
                Text("Live")
                    .font(.system(size: 25))
                    .tint(.black)
            }
        }
        .padding(.top, 30)
    }
    
    var userStatView: some View {
        HStack(spacing: 50) {
            UserStatView(value: 1, title: "Following")
            UserStatView(value: 1, title: "Likes")
            UserStatView(value: 1, title: "Followers")
        }
        .padding(.top, 15)
        .padding(.bottom, 15)
    }
}

struct DetailUsersPostGridView: View {
    private let items = [
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1)
    ]
    var body: some View {
        LazyVGrid(columns: items, spacing: 2){
            ForEach(0..<9) { post in
                Image("testImg")
                    .resizable()
                    .frame(width: 120, height: 150)
                    .clipped()
            }
        }
    }
}

//#Preview {
//    UserDetailsView(users: )
//}
