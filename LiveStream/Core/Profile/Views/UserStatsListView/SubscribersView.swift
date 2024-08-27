//
//  UserFollowersView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 20.08.24.
//

import SwiftUI

struct SubscribersView: View {
    var body: some View {
        VStack {
            NavigationStack {
                ScrollView {
                    LazyVStack(spacing: 13) {
                        ForEach(0..<5) { following in
                            HStack {
                                UsersActionCell(imageSystemName: "person.circle.fill",
                                                primaryText: "GoreTechno ",
                                                secondaryText: "subscribed to you",
                                                timeAgoText: "7 years ago",
                                                trailingImage: nil)
                                .padding(.top, 13)
                            }
                        }
                    }
                }
            }
        }
    }
}
