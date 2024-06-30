//
//  SendMessageView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 30.06.24.
//

import SwiftUI

struct SendMessageView: View {
    @State private var text = ""
    @State private var messages: [Messages] = [
        Messages(username: "Alex", content: "Hello"),
        Messages(username: "Goga", content: "Who are you? "),
        Messages(username: "Max", content: "ls mid push ? ")
    ]
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(messages) { message in
                        VStack(alignment: .leading) {
                            Text(message.username)
                                .fontWeight(.bold)
                            Text(message.content)
                        }
                        .foregroundColor(.white)
                    }
                }
            }
            .frame(maxHeight: 200)
            .frame(height: 150)
            .padding(.bottom, 5)
            .onChange(of: messages) {
                if let lastMessage = messages.last {
                    withAnimation {
                        proxy.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
            }
        }
        HStack {
            TextField("Enter your message", text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                let newMessage = Messages(username: "Current User", content: text)
                messages.append(newMessage)
                text = ""
            }) {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.orange)
            }
        }
    }
}

#Preview {
    SendMessageView()
}
