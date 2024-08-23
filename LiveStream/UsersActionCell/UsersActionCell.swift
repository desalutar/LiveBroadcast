//
//  UsersActionCell.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 21.08.24.
//

import SwiftUI

struct UsersActionCell: View {
    let imageSystemName: String
    let primaryText: String
    let secondaryText: String
    let timeAgoText: String
    let trailingImage: Image?
    
    var body: some View {
        HStack {
            Image(systemName: imageSystemName)
                .resizable()
                .frame(width: 38, height: 38)
                .foregroundStyle(Color(.systemGray4))
            
            HStack {
                Text(primaryText)
                    .font(.footnote)
                    .fontWeight(.semibold) +
                
                Text(secondaryText)
                    .font(.footnote) +
                
                Text(timeAgoText)
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            Spacer()
            
            if let trailingImage = trailingImage {
                trailingImage
                    .resizable()
                    .frame(width: 48, height: 48)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    UsersActionCell()
//}
