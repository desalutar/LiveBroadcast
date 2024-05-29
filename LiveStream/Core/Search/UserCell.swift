//
//  UserCell.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 24.05.24.
//

import SwiftUI

struct UserCell: View {
    var body: some View {
        HStack(spacing: 13) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(maxWidth: 43, maxHeight: 45)
                .foregroundStyle(Color(.systemGray3))
            
            VStack(alignment: .leading) {
                Text("Nickname")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text("User name")
                    .font(.footnote)
            }
            Spacer()
        }
        .padding(.horizontal, 17)
    }
}

#Preview {
    UserCell()
}
