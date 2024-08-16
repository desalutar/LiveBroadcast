//
//  AuthorizationView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 14.07.24.
//

import SwiftUI

struct AuthorizationView: View {
    @EnvironmentObject var appState: UserSessionManager
    @StateObject var viewModel = AuthorizationViewModel()
    @State private var user: User?
    @State private var name = ""
    @State private var lastName = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
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
            .padding(viewModel.isAuth ? 25 : 20)
            .background(.black)
        }
        .padding(.bottom, 70)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .animation(Animation.linear(duration: 0.3), 
                   value: viewModel.isAuth)
        .fullScreenCover(isPresented: $viewModel.isShowMapView) {
            MainTabView(appState: _appState)
        }
    }
    
    var authText: some View {
        Text(viewModel.isAuth ? "Authorization" : "Registration")
            .font(.title2.bold())
            .padding(16)
            .padding(.horizontal, 30)
            .border(.orange)
            .foregroundStyle(.orange.opacity(0.7))
            .clipShape(RoundedRectangle(cornerRadius: viewModel.isAuth ? 30 : 35))
    }
    
    var authFields: some View {
        VStack {
            TextField(text: $username)  {
                Text("Enter login / username")
                    .foregroundStyle(.black)
            }
            .customTextFieldStyle()
            SecureField(text: $password) {
                Text("Enter password")
                    .foregroundStyle(.black)
            }.customTextFieldStyle()
            
            if !viewModel.isAuth {
                SecureField(text: $confirmPassword) {
                    Text("Confirm password")
                        .foregroundStyle(.black)
                }.customTextFieldStyle()
                
                TextField(text: $name)  {
                    Text("Enter Name")
                        .foregroundStyle(.black)
                }.customTextFieldStyle()
                
                TextField(text: $lastName)  {
                    Text("Enter last name")
                        .foregroundStyle(.black)
                }.customTextFieldStyle()
            }
        }
    }
    
    var authButtons: some View {
        VStack {
            Button {
                Task {
                    do {
                        switch viewModel.isAuth {
                        case true:
                            self.user = try await viewModel.authenticationUser(with: username, password)
                            guard let user else { return }
                            appState.selectedUser.append(user)
                            viewModel.isShowMapView.toggle()
                        case false:
                            self.user = try await viewModel.authenticationUser(with:                            username, password,                           name, lastName)
                            viewModel.isAuth.toggle()
                        }
                    } catch {
                        print("Ошибка: \(error.localizedDescription)")
                    }
                }
            } label: {
                Text(viewModel.isAuth ? "Sign in" : "Create account")
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .customTextFieldStyle()
            }
            
            Button {
                viewModel.isAuth.toggle()
            } label: {
                Text(viewModel.isAuth ? "Sign up" : "Sign in")
                    .foregroundStyle(.orange)
            }.padding(.horizontal)
            
            .fullScreenCover(isPresented: $viewModel.isShowMapView) {
                MainTabView(appState: _appState)
            }
        }
    }
}

#Preview {
    AuthorizationView()
}
