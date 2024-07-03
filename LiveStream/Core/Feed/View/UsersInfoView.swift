//
//  UsersInfoView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 30.06.24.
//

import SwiftUI

struct UsersInfoView: View {
    @EnvironmentObject var selectedUser: UserSessionManager
    @StateObject var locationManager = LocationManager()
    @State private var isShowUsersInfo = false
    
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
            ScrollView {
                VStack {
                    userInfoItem
                    subscribeButton
                    reportButton
                }
            }
            .scrollIndicators(.hidden)
            .presentationDetents([.fraction(0.27)])
            .presentationDragIndicator(.visible)
            .padding()
        })
    }
    
    var userInfoItem: some View {
        HStack(spacing: 10) {
            Image(systemName: "person")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.leading, 10)
            VStack(alignment: .listRowSeparatorLeading) {
                Text(selectedUser.selectedUser.last?.name ?? "")
                    .font(.headline)
                Text("location title")
            }
            Spacer()
            openUserProfile
        }
        .padding()
    }
    
    var openUserProfile: some View {
        Button {
            selectedUser.selectedTab = 4
            isShowUsersInfo = false
        } label: {
            Image(systemName: "person.crop.square.fill")
        }
        .padding(.trailing, 10)
    }
    
    var subscribeButton: some View {
        Button {
            print("subscribe")
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.orange)
                    .frame(width: 350, height: 52)
                Text("Subscribe")
                    .font(.system(size: 25))
                    .tint(.black)
            }
            .padding()
        }
    }
    
    var reportButton: some View {
        Button {
            print("report")
        } label: {
            Text("Report")
                .fontWeight(.heavy)
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    UsersInfoView()
}

