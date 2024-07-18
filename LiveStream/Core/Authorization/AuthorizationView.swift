//
//  AuthorizationView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 14.07.24.
//

import SwiftUI

struct AuthorizationView: View {
    @EnvironmentObject var appState: UserSessionManager
    @State private var isAuth = true
    @State private var login = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var user: User?
    
    @State private var isShowMapView = false
    var body: some View {
        VStack(spacing: 13) {
            authText
            VStack {
                authFields
                authButtons
            }
            .padding()
            .padding(.bottom, 13)
            .background(.white.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .padding(isAuth ? 25 : 20)
            .background(.black)
        }
        .padding(.bottom, 70)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .animation(Animation.linear(duration: 0.3), value: isAuth)
        .fullScreenCover(isPresented: $isShowMapView) {
            MainTabView(appState: _appState)
        }
    }
    
    var authText: some View {
        Text(isAuth ? "Authorization" : "Registration")
            .font(.title2.bold())
            .padding(16)
            .padding(.horizontal, 30)
            .border(.orange)
            .foregroundStyle(.orange.opacity(0.7))
            .clipShape(RoundedRectangle(cornerRadius: isAuth ? 30 : 35))
    }
    
    var authFields: some View {
        VStack {
            TextField(text: $login)  {
                Text("Enter login / username")
                    .foregroundStyle(.black)
            }
            .padding()
            .foregroundStyle(.black)
            .background(.orange.opacity(0.7))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(8)
            .padding(.horizontal, 12)
            SecureField(text: $password) {
                Text("Enter password")
                    .foregroundStyle(.black)
            }
            .padding()
            .foregroundStyle(.black)
            .background(.orange.opacity(0.7))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(8)
            .padding(.horizontal, 12)
            
            if !isAuth {
                SecureField(text: $confirmPassword) {
                    Text("Confirm password")
                        .foregroundStyle(.black)
                }
                .padding()
                .foregroundStyle(.black)
                .background(.orange.opacity(0.7))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding(8)
                .padding(.horizontal, 12)
            }
        }
    }
    
    var authButtons: some View {
        VStack {
            Button {
                if isAuth {
                    Task {
                        do {
                            self.user = try await AuthNetworkService.shared.auth(username: login,
                                                               password: password)
                            print(user?.name ?? "nil")
    //                        isShowMapView.toggle()
                        } catch {
                            print("Ошибка: \(error.localizedDescription)")
                        }
                    }
                } else {
                    print("sign up user")
                    self.login = ""
                    self.password = ""
                    self.confirmPassword = ""
                    self.isAuth.toggle()
                }
            } label: {
                Text(isAuth ? "Sign in" : "Create account")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.orange.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(8)
                    .padding(.horizontal, 12)
                    .foregroundStyle(.black)
                    .font(.title3.bold())
            }
            
            Button {
                isAuth.toggle()
            } label: {
                Text(isAuth ? "Sign up" : "Sign in")
                    .foregroundStyle(.orange)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    AuthorizationView()
}
