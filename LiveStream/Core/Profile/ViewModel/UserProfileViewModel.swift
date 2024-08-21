//
//  UserProfileViewModel.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 20.08.24.
//

import Foundation
import SwiftUI

class UserProfileViewModel: ObservableObject {
    
    func userStatNavigationLink(destination: some View, value: Int, title: String) -> some View {
        NavigationLink(destination: destination) {
            UserStatView(value: value, title: title)
                .foregroundStyle(.orange)
        }
    }
    
    
}
