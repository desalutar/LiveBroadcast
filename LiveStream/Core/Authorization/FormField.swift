//
//  AutherizationView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 16.08.24.
//

import SwiftUI

struct FormField: View {
    var fieldName = ""
    @Binding var fieldValue: String
    var isSecure: Bool = false
    
    var body: some View {
        VStack {
            switch isSecure {
            case true:
                SecureField(text: $fieldValue) {
                    Text(fieldName)
                        .foregroundStyle(.black)
                }.customTextFieldStyle()
            case false:
                TextField(text: $fieldValue) {
                    Text(fieldName)
                        .foregroundStyle(.black)
                }.customTextFieldStyle()
            }
        }
    }
}
