//
//  ProfileHeaderView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 24.05.24.
//

import SwiftUI

struct ProfileHeaderView: View {
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 8) {
                // profile image
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundStyle(Color(.systemGray4))
                // username
                Text("@alwis.hameston")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            
            // status view
            HStack(spacing: 16) {
                UserStatView(value: 5, title: "Following")
                UserStatView(value: 12357, title: "Followers")
                UserStatView(value: 52383, title: "Likes")
            }
            // action button
            Button {
                
            } label: {
                Text("Edit Profile")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 32)
                    .foregroundStyle(.black)
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            Divider()
        }
    }
}

#Preview {
    ProfileHeaderView()
}
