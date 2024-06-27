//
//  UserDetailsView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 27.06.24.
//

import SwiftUI

struct UserDetailsView: View {
    @Binding var users: Users?
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .padding(.leading, 30)
                    VStack(alignment: .listRowSeparatorLeading) {
                        Text(users?.name ?? "nil")
                            .font(.headline)
                        Text(locationManager.locationName)
                    }
                    .padding(.leading, 20)
                    Spacer()
                }
                
                Button {
                    // action for watch broadcast
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.orange)
                            .frame(width: 350, height: 52)
                        Text("Live")
                            .font(.system(size: 25))
                    }
                }
                .padding(.top, 30)
            }
            .padding(.top, 30)
            .onAppear {
                locationManager.fetchLocationName(for: users?.coordinate ?? .moscowCity)
            }
        }
    }
}

//#Preview {
//    UserDetailsView(users: $mock)
//}
