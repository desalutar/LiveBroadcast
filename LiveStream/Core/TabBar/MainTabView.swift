//
//  MainTabView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 24.05.24.
//

import SwiftUI
import UIKit

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var viewModel = ViewModel()
    var body: some View {
        TabView(selection: $selectedTab) {
            MapView(changeScreen: $selectedTab)
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 0 ? "globe" : "globe")
                            .environment(\.symbolVariants, 
                                          selectedTab == 0 ? .fill : .none)
                        Text("Map")
                    }
                }
                .onAppear { selectedTab = 0 }
                .tag(0)
            
            OnlineBroadcasts()
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 1 ? "rectangle.stack.badge.person.crop.fill" : "rectangle.stack.badge.person.crop")
                            .environment(\.symbolVariants, 
                                          selectedTab == 1 ? .fill : .none)
                        Text("Broacasts")
                    }
                }
                .onAppear { selectedTab = 1 }
                .tag(1)
            
            BroadcastView(image: $viewModel.currentFrame)
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 2 ? "plus.circle.fill" : "plus.circle")
                            .environment(\.symbolVariants,
                                          selectedTab == 4 ? .fill : .none)
                        Text("Go Online")
                    }
                }
                .onAppear { selectedTab = 2 }
                .tag(2)
                .tint(.cyan)
            
            NotificationsView()
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 3 ? "bell.fill" : "bell")
                            .environment(\.symbolVariants,
                                          selectedTab == 3 ? .fill : .none)
                        Text("Notifications")
                    }
                }
                .onAppear { selectedTab = 3 }
                .tag(3)
            
            CurrentUserProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                            .environment(\.symbolVariants,
                                          selectedTab == 4 ? .fill : .none)
                        Text("Profile")
                    }
                }
                .onAppear { selectedTab = 4 }
                .tag(4)
        }
        .tint(.orange)
    }
}

#Preview {
    MainTabView()
        .preferredColorScheme(.dark)
}
