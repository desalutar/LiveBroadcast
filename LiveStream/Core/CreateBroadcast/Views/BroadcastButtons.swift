//
//  BroadcasButtons.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 29.05.24.
//

import SwiftUI

struct BroadcastButtons: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    // кнопка для смены камеры
                } label: {
                    Image(systemName: "arrow.triangle.2.circlepath.camera.fill")
                        .resizable()
                        .frame(maxWidth: 29, maxHeight: 25)
                        .padding(13)
                        .foregroundStyle(.white)
                }
                Button {
                    // кнопка для запуска трансляции
                } label: {
                    Image(systemName: "play.fill")                      
                        .resizable()
                        .frame(maxWidth: 25, maxHeight: 25)
                        .padding(13)
                }
                
                Spacer()
            }
            .padding(.bottom, 20)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.circle)
            .opacity(0.6)
        }
        .tint(.clear)
    }
}

#Preview {
    BroadcastButtons()
}
