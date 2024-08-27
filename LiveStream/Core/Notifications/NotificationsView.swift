//
//  NotificationsView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 24.05.24.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 24) {
                    ForEach(0..<5) { notification in
                        HStack {
                            UsersActionCell(imageSystemName: "person.circle.fill",
                                            primaryText: "max+100500 ",
                                            secondaryText: "Liked one of your broadcast ",
                                            timeAgoText: "11 min ago",
                                            trailingImage: nil)
                            Rectangle()
                                .frame(width: 48, height: 48)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                        }.padding(.trailing, 25)
                        
                    }
                }
            }
            .tint(.orange)
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top)
        }
    }
}

#Preview {
    NotificationsView()
}
