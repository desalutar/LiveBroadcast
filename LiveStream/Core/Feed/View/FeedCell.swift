//
//  FeedCell.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 24.05.24.
//

import SwiftUI
import AVKit

struct FeedCell: View {
    let post: Post
    var player: AVPlayer
    @State private var isPresented = false
    @State private var text = ""
    @State private var messages: [Messages] = [
        Messages(username: "Alex", content: "Hello"),
        Messages(username: "Goga", content: "Who are you? ")
    ]
    
    init(post: Post, player: AVPlayer) {
        self.post = post
        self.player = player
    }
    
    var body: some View {
        ZStack {
            CustomVideoPlayer(player: player)
                .containerRelativeFrame([.horizontal, .vertical])
            VStack(alignment: .leading) {
                UsersInfoView()
                    .padding(.top, 20)
                Spacer()
                SendMessageView()
            }
            .padding()
            .padding(.bottom, 85)
        }
        
        .onTapGesture {
            switch player.timeControlStatus {
            case .paused:
                player.play()
            case .waitingToPlayAtSpecifiedRate:
                break
            case .playing:
                player.pause()
            @unknown default:
                break
            }
        }
    }
}

#Preview {
    FeedCell(post: Post(id: NSUUID().uuidString, videoUrl: ""), player: AVPlayer())
}
