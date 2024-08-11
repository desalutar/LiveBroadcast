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
            HStack {
                HStack(spacing: 13) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundStyle(Color(.systemGray4))
                        .padding(.leading, 16)
                    VStack(alignment: .center) {
                        Text("name lastname")
                            .font(.title2)
                            .fontWeight(.bold)
                        userStats
                        Spacer()
                    }
                }
                Spacer()
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
            .padding(.top, 10)
            .padding(.bottom, 16)
            Divider()
        }
    }
    
    var userStats: some View {
        HStack(spacing: 16) {
            UserStatView(value: 5, title: "Following")
            UserStatView(value: 12357, title: "Followers")
            UserStatView(value: 52383, title: "Likes")
        }
    }
}

#Preview {
    ProfileHeaderView()
}
