//
//  UsersInfoView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 30.06.24.
//

import SwiftUI

struct UsersInfoView: View {
    @State private var isShowUsersInfo = false
    @State private var selectedUser: Users?
    var body: some View {
        HStack {
            Spacer()
            ZStack {
                Circle()
                    .frame(width: 33, height: 33)
                Image(systemName: "person")
                    .resizable()
                    .foregroundStyle(.black)
                    .frame(width: 20, height: 20)
            }
        }
        .onTapGesture {
            isShowUsersInfo = true
        }
        .sheet(isPresented: $isShowUsersInfo, content: {
            UserDetailsView(users: $selectedUser)
        })
    }
}

#Preview {
    UsersInfoView()
}

