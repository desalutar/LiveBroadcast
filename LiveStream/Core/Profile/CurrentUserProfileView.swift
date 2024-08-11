//
//  CurrentUserProfileView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 24.05.24.
//

import SwiftUI

struct CurrentUserProfileView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 2) {
                     // profile header
                    ProfileHeaderView()
                    // post grid view
                    PostGridView()
                }
                .padding(.top   )
            }
            .navigationTitle("username")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

#Preview {
    CurrentUserProfileView()
}
