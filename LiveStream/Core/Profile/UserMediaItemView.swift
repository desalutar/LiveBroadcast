//
//  UserMediaItemView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 25.08.24.
//

import SwiftUI

struct UserMediaItem: Codable {
    var id: String
    var userPhoto: String?
    var userVideo: String?
    var userBroadcast: String?
}

struct UserMediaItemView: View {
    @State private var isExpanded = false
    let item: UserMediaItem

    init(item: UserMediaItem) {
        self.item = item
    }

    var body: some View {
        VStack {
            Image("testImg")
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(height: isExpanded ? 600 : 350)
                .padding()
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
        }
    }
}

struct UserMediaScreen: View {
    let mediaItems: [UserMediaItem] = []

    var body: some View {
        ScrollView {
            VStack {
                ForEach(mediaItems, id: \.id) { item in
                    UserMediaItemView(item: item)
                }
            }
        }
    }
}

struct UserMediaItemView_Previews: PreviewProvider {
    static var previews: some View {
        UserMediaItemView(item: UserMediaItem(id: "1",
                                              userPhoto: "photo1",
                                              userVideo: "video1",
                                              userBroadcast: "broadcast1")
        )
    }
}
