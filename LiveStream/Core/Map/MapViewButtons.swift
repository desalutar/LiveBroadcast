//
//  UserCell.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 24.05.24.
//

import SwiftUI

struct MapViewButtons: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                ZStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "location.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.black)
                    }
                }
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    MapViewButtons()
}
