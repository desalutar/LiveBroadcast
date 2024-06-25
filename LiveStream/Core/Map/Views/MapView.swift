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
    @State var ispresent = false
    @State private var selectedUser: Users?
    @ObservedObject private var locationManager = LocationManager()
    @StateObject private var networkManager = NetworkManager()
    
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
                            ispresent.toggle()
                        }
                    }
                }
            }
            .mapControlVisibility(.hidden)
            .mapStyle(.hybrid(elevation: .realistic))
            .onAppear {
                locationManager.requestLocation()
                networkManager.start()
                
            }
            MapButtons(cameraPosition: $cameraPosition, 
                       locationManager: locationManager)
        }
        .sheet(isPresented: $ispresent, content: {
            VStack {
                Text(selectedUser?.name ?? "")
            }
        })
    }
}

extension CLLocationCoordinate2D {
    static let moscowCity =
    CLLocationCoordinate2D(
        latitude: 55.75222,
        longitude:  37.61556
    )
}

#Preview {
    MapView()
}

