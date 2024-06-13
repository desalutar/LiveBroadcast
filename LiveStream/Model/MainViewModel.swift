//
//  MainViewModel.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 13.06.24.
//

import Foundation

struct MainViewModel {
    var usersCount = [Users]()
    var userLocation = [UserLocation(latitude: String(55.75222), longitude: String(37.61556))]
    
}

struct Users {
    var id = UUID()
    var name: String
    var lastName: String
}

struct UserLocation {
    var latitude: String
    var longitude: String
}
