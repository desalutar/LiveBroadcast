//
//  UserProfileViewModel.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 20.08.24.
//

import Foundation
import SwiftUI
import PhotosUI

class ProfileViewModel: ObservableObject {
    @Published var isShowingNotifications = false
    @Published var profileImage: Image?
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { try await loadImage() } }
    }
    
    func userStatNavigationLink(destination: some View, value: Int, title: String) -> some View {
        NavigationLink(destination: destination) {
            UserStatView(value: value, title: title)
                .foregroundStyle(.orange)
        }
    }
    
    func loadImage() async throws {
        guard let selectedImage else { return }
        guard let imageData = try await selectedImage.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: imageData) else { return }
        self.profileImage = Image(uiImage: uiImage)
    }
    
}
