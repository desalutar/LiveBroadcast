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
    
    init(post: Post, player: AVPlayer) {
        self.post = post
        self.player = player
    }
    
    var body: some View {
        ZStack {
            CustomVideoPlayer(player: player)
                .containerRelativeFrame([.horizontal, .vertical])
            
            VStack {
                
                Spacer()
                
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading ) {
                        Text("carlos.sainz")
                            .fontWeight(.semibold)
                        
                        Text("Rocket ship prepare for takeOff")
                    }
                    .foregroundStyle(.white)
                    .font(.subheadline)
                    Spacer()
                    VStack(spacing: 28) {
                        
                        Circle()
                            .frame(maxWidth: 38, maxHeight: 38)
                            .foregroundStyle(.gray)
                        
                        Button {
                            // кнопка лайка
                        } label: {
                            VStack {
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                    .foregroundStyle(.white)
                                Text("27")
                                    .font(.caption)
                                    .foregroundStyle(.white)
                                    .bold() 
                            }
                        }
                         
                        Button {
                            // кнопка коментов
                        } label: {
                            VStack {
                                Image(systemName: "ellipsis.bubble.fill")
                                    .resizable()
                                    .frame(width: 26, height: 28)
                                    .foregroundStyle(.white)
                                Text("27")
                                    .font(.caption)
                                    .foregroundStyle(.white)
                                    .bold()
                            }
                        }
                        
                        Button {
                            // кнопка для добавление в избранное
                        } label: {
                            Image(systemName: "bookmark.fill")
                                .resizable()
                                .frame(width: 21, height: 28)
                                .foregroundStyle(.white)
                        }
                        
                        Button {
                            // кнопка поделиться
                        } label: {
                            Image(systemName: "arrowshape.turn.up.right.fill")
                                .resizable()
                                .frame(width: 27, height: 26)
                                .foregroundStyle(.white)
                        }
                    }
                }
                .padding(.bottom, 89)
            }
            .padding()
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
