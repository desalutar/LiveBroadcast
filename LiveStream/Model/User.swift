//
//  User.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 24.08.24.
//

import Foundation
import CoreLocation

struct User: Codable, Identifiable {
    var id: String
    let name: String
    let username: String
    let lastName: String
    var userProfilePhoto: String?
    let address: Address?
    var userStats: UserStats?
    var userPostItem: UserPostItem?
    
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

struct UserStats: Codable {
    var followersCount: String
    var followingCount: String
    var likesCount: String
}

struct UserPostItem: Codable {
    var itemId: String
    var itemComment: String
}


