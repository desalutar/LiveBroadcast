//
//  UserSessionManager.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 24.08.24.
//

import Foundation

class UserSessionManager: ObservableObject {
    @Published var selectedUser: [User] = []
    @Published var selectedTab = 0
    
    init() {
        let defaultUser = User(id: UUID().uuidString, name: "oleg", username: "xxxtentation", lastName: "borisov", userProfilePhoto: nil, address: Address(geo: Geo(lat: "55.597480", lng: "38.119811")), userStats: UserStats(followersCount: "3567", followingCount: "132", likesCount: "9012"), userPostItem: UserPostItem(itemId: "123122", itemComment: "good comment from init"), userLatitude: 55.597480, userLongitude: 38.119811)
        selectedUser.append(defaultUser)
    }
}
