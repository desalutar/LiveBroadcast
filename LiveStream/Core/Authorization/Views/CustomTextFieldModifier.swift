//
//  CustomTextFieldModifier.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 16.08.24.
//

import SwiftUI

struct CustomTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundStyle(.black)
            .background(.orange.opacity(0.7))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(8)
            .padding(.horizontal, 12)
    }
}

extension View {
    func customTextFieldStyle() -> some View {
        modifier(CustomTextFieldModifier())
    }
}
