//
//  ContentGridCellView .swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 23.08.24.
//

import SwiftUI

struct ContentGridCellView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: -1) {
                HStack {
                    userHeader
                }
                
                Rectangle()
                    .padding()
                    .frame(width: 400, height: 400)
                
                HStack {
                    likeButton
                    Spacer()
                    commentButton
                    Spacer()
                    shareButton
                        .padding(.trailing, 13)
                }
                .padding(.leading, 5)
                .foregroundStyle(.orange)
                
                Spacer()
                
            }.padding()
        }
    }
    
    var userHeader: some View {
        HStack {
            Button {
                // user image
            } label: {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(maxWidth: 42, maxHeight: 42)
                    .aspectRatio(contentMode: .fill)
                    .tint(.orange)
            }.padding(.leading, 5)
            
            VStack {
                Text("User name")
            }
            Spacer()
        }.padding(.leading, 10)
    }
    
    var likeButton: some View {
        Button {
            // like button
        } label: {
            Image(systemName: "heart")
                .resizable()
                .frame(maxWidth: 23, maxHeight: 23)
                .aspectRatio(contentMode: .fill)
        }.padding(.horizontal, 10)
    }
    
    var commentButton: some View {
        Button {
            // comment button
        } label: {
            Image(systemName: "bubble.left")
                .resizable()
                .frame(maxWidth: 23, maxHeight: 23)
                .aspectRatio(contentMode: .fill)
        }.padding(.horizontal, 10)
    }
    
    var shareButton: some View {
        Button {
            // share button
        } label: {
            Image(systemName: "arrowshape.turn.up.right")
                .resizable()
                .frame(maxWidth: 23, maxHeight: 23)
                .aspectRatio(contentMode: .fill)
        }.padding(.horizontal, 10)
    }
}
#Preview {
    ContentGridCellView()
}
