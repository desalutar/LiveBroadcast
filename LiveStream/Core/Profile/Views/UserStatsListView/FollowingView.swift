//
//  UserFollowingView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 20.08.24.
//

import SwiftUI

struct FollowingView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 13) {
                    ForEach(0..<5) { following in
                        HStack {
                            UsersActionCell(imageSystemName: "person.circle.fill",
                                            primaryText: "you subscribed ",
                                            secondaryText: "GoreTechno ",
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

#Preview {
    FollowingView()
}
