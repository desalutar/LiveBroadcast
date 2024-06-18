//
//  BottonSheet.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 16.06.24.
//

import Foundation
import SwiftUI
struct ButtonSheet: View {
    @GestureState private var gestureOffset = CGSize.zero
    @State private var currentMenuOffsetY: CGFloat = 0.0
    @State private var lastMenuOffsetY: CGFloat = 0.0
    var dragGesture: some Gesture {
        DragGesture()
            .updating($gestureOffset) { value, state, transaction in
                state = value.translation
                onChangeMenuOffset()
            }
            .onEnded { value in
                withAnimation {
//                    currentMenuOffsetY = 0
                    lastMenuOffsetY = currentMenuOffsetY
                }
            }
    }
    
    func onChangeMenuOffset() {
        DispatchQueue.main.async {
            currentMenuOffsetY = gestureOffset.height + lastMenuOffsetY
        }
    }
    
    var body: some View {
        ZStack {
            Color("background")
            
            VStack {
                Capsule()
                    .fill(.white)
                    .frame(width: 80, height: 3)
                    .padding()
                ForEach(0..<4) { _ in
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("action"))
                        .frame(height: 100)
                        .padding(.horizontal)
                }
                Spacer()
            }
            .frame(height: UIScreen.main.bounds.height + 100)
            .background(RoundedRectangle(cornerRadius: 20).fill(Color("alert")))
            .ignoresSafeArea(.all, edges: .bottom)
            .offset(y: UIScreen.main.bounds.height)
            .offset(y: currentMenuOffsetY)
            .gesture(dragGesture)
        }
        .ignoresSafeArea(edges: .top)
    }
}
#Preview {
    ButtonSheet()
}
