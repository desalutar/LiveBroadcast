//
//  MainViewModel.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 13.06.24.
//

import Foundation
import CoreLocation

struct MainViewModel {
    var usersCount = [User]()
}

class UserSessionManager: ObservableObject {
    @Published var selectedUser: [User] = []
    @Published var selectedTab = 0
}

struct User: Codable, Identifiable {
    
    var id: String
    let name: String
    let username: String
    let lastName: String
    let address: Address?
    
    var userLatitude: Double?
    var userLongitude: Double?
    
    var coordinate: CLLocationCoordinate2D? {
        guard let latitudeStrings = address?.geo.lat,
              let longitudeStrings = address?.geo.lng,
              let latitude = Double(latitudeStrings),
              let longitude = Double(longitudeStrings) else {
            return nil
        }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct Address: Codable {
    let geo: Geo
}

struct Geo: Codable {
    let lat, lng: String?
}

struct Messages: Identifiable, Equatable {
    let id = UUID()
    var username: String
    var content: String
}

struct UsersStats: Codable {
    var followersCount: String
    var followingCount: String
    var likesCount: String
}
