//
//  MainTabView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 24.05.24.
//

import SwiftUI
import UIKit

struct MainTabView: View {
    @EnvironmentObject var appState: UserSessionManager
    @State private var viewModel = ViewModel()
    
    var body: some View {
        TabView(selection: $appState.selectedTab) {
            MapView()
                .tabItem {
                    VStack {
                        Image(systemName: "globe")
                        Text("Map")
                    }
                }
                .onAppear { appState.selectedTab = 0 }
                .tag(0)
            
            OnlineBroadcasts()
                .tabItem {
                    VStack {
                        Image(systemName: appState.selectedTab == 1 ? "rectangle.stack.badge.person.crop.fill" : "rectangle.stack.badge.person.crop")
                            .environment(\.symbolVariants, 
                                          appState.selectedTab == 1 ? .fill : .none)
                        Text("Broacasts")
                    }
                }
                .onAppear { appState.selectedTab = 1 }
                .tag(1)
            
            BroadcastView(image: $viewModel.currentFrame)
                .tabItem {
                    VStack {
                        Image(systemName: appState.selectedTab == 2 ? "plus.circle.fill" : "plus.circle")
                            .environment(\.symbolVariants,
                                          appState.selectedTab == 4 ? .fill : .none)
                        Text("Go Online")
                    }
                }
                .onAppear { appState.selectedTab = 2 }
                .tag(2)
                .tint(.cyan)
            
            CurrentUserProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: appState.selectedTab == 4 ? "person.fill" : "person")
                            .environment(\.symbolVariants,
                                          appState.selectedTab == 4 ? .fill : .none)
                        Text("Profile")
                    }
                }
                .onAppear { appState.selectedTab = 4 }
                .tag(4)
        }
        .tint(.orange)
    }
}

#Preview {
    MainTabView()
        .environmentObject(UserSessionManager())
        .preferredColorScheme(.dark)
}
