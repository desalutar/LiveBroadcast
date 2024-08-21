//
//  PostGridView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 24.05.24.
//

import SwiftUI

struct PostGridView: View {
    private let items = [
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1)
    ]
    private let width = (UIScreen.main.bounds.width / 3) 
    var body: some View {
        LazyVGrid(columns: items, spacing: 2){
            ForEach(0..<10) { post in
                Rectangle()
                    .frame(width: width, height: 210)
                    .clipped()
            }
        }
    }
}

#Preview {
    PostGridView()
}
