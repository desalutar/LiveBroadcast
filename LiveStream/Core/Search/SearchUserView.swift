//
//  ExploreView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 24.05.24.
//

import SwiftUI

struct SearchUserView: View {
    @State private var showAlert = false
    @State private var placeholder = ""
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(0..<5) { user in
                        UserCell()
                    }
                }
            }
            .navigationTitle("Users")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top)
            
            // Search Users
            .toolbar {
                Button {
                    showAlert = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .alert("Enter username", 
                   isPresented: $showAlert,
                   actions: {
                TextField(text: $placeholder) { Text("Username") }
                
                Button("Search") { showAlert = false }
                Button("Cancel") { showAlert = false }
            })
        }
    }
}

#Preview {
    SearchUserView()
}
