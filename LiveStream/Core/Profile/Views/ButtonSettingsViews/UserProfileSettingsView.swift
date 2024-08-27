//
//  UserProfileSettingsView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 20.08.24.
//

import SwiftUI

struct UserProfileSettingsView: View {
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section("Account") {
                        NavigationLink(destination: StatisticsView()) {
                            SettingRowView(title: "Statistics",
                                           systemImage: "person.fill")
                        }
                        NavigationLink(destination: RatingView()) {
                            SettingRowView(title: "Rating",
                                           systemImage: "trophy.fill")
                        }
                        NavigationLink(destination: AppearanceView()) {
                            SettingRowView(title: "Appearance",
                                           systemImage: "wand.and.stars.inverse")
                        }
                        NavigationLink(destination: NotificationView()) {
                            SettingRowView(title: "Notifications",
                                           systemImage: "bell.fill")
                        }
                        NavigationLink(destination: LanguageView()) {
                            SettingRowView(title: "Language",
                                           systemImage: "globe")
                        }
                    }
                    Section("Privacy") {
                        NavigationLink(destination: BlackListView()) {
                            SettingRowView(title: "Black list",
                                           systemImage: "xmark.circle")
                        }
                        NavigationLink(destination: PermissionView()) {
                            SettingRowView(title: "Permissions",
                                           systemImage: "shield.fill")
                        }
                    }
                    
                    Section("Support") {
                        NavigationLink(destination: HelpSupportView()) {
                            SettingRowView(title: "Help & Support",
                                           systemImage: "questionmark.circle")
                        }
                        NavigationLink(destination: AboutUSView()) {
                            SettingRowView(title: "About Us",
                                           systemImage: "info.circle")
                        }
                    }
                }

                    Button {
                        // проработать выход из системы
                    } label: {
                        Text("Log out")
                            .foregroundStyle(.red)
                    }.padding(.bottom, 50)
            }
        }
        .navigationTitle(Text("Settings"))
        .tint(.orange)
    }
      
}

#Preview {
    UserProfileSettingsView()
}
