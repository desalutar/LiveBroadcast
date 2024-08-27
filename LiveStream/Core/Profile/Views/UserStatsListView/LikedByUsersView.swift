//
//  UserLikesView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 20.08.24.
//

import SwiftUI

struct LikedByUsersView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 13) {
                    ForEach(0..<5) { following in
                        HStack {
                            UsersActionCell(imageSystemName: "person.circle.fill",
                                            primaryText: "GoreTechno ",
                                            secondaryText: "liked yor broadcast",
                                            timeAgoText: "",
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
    LikedByUsersView()
}
