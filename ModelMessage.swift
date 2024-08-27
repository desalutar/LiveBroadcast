//
//  ModelMessage.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 24.08.24.
//

import Foundation

struct Messages: Identifiable, Equatable {
    let id = UUID()
    var username: String
    var content: String
}
