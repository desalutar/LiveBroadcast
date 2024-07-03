//
//  MapView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 13.06.24.
//

import SwiftUI
import MapKit
import _CoreLocationUI_SwiftUI

struct MapView: View {
    @ObservedObject private var locationManager = LocationManager()
    @StateObject private var networkManager = NetworkManager()
    @State private var bottomSheetShown = false
    @State private var selectedUser: Users?
    @State private var cameraPosition: MapCameraPosition = .userLocation(
        followsHeading: true,
        fallback: .camera(MapCamera(
            centerCoordinate: .moscowCity,
            distance: 34538979)
        )
    )
    
    var body: some View {
        ZStack {
            Map(position: $cameraPosition) {
                ForEach(networkManager.users) { user in
                    Annotation(user.name ?? "",
                               coordinate: user.coordinate ?? .moscowCity) {
                        ZStack {
                            Image(systemName: "person")
                       }
                        .onTapGesture {
                            selectedUser = user
                            bottomSheetShown.toggle()
                        }
                    }
                }
            }
            .mapControlVisibility(.hidden)
            .mapStyle(.hybrid(elevation: .realistic))
            .sheet(isPresented: $bottomSheetShown) {
                UserDetailsView(users: $selectedUser,
                                showingSheet: $bottomSheetShown)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
                    .padding()
            }
            
            DisplayYourGeolocation(cameraPosition:  $cameraPosition,
                                   locationManager: locationManager)
        }
        .onAppear {
            locationManager.requestLocation()
            networkManager.start()
        }
    }
}

extension CLLocationCoordinate2D {
    static let moscowCity =
    CLLocationCoordinate2D(
        latitude: 55.75222,
        longitude:  37.61556
    )
}

//#Preview {
//    MapView(selectedTab: )
//}

