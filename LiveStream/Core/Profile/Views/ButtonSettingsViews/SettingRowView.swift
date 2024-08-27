//
//  SettingRowView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 21.08.24.
//

import SwiftUI

struct SettingRowView: View {
    var title: String
    var systemImage: String
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: systemImage)
                .foregroundStyle(.orange)
            Text(title)
        }
    }
}

#Preview {
    SettingRowView(title: "asd", systemImage: "person")
}
