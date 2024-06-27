//
//  MapButtons.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 24.06.24.
//

import SwiftUI
import MapKit
import _CoreLocationUI_SwiftUI

struct MapButtons: View {
    @Binding var cameraPosition: MapCameraPosition
    @ObservedObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                LocationButton(.sendCurrentLocation) {
                    locationManager.requestLocation()
                    cameraPosition = .userLocation(followsHeading: true, fallback: .camera(MapCamera(centerCoordinate: locationManager.currentCoordinate ?? .moscowCity, distance: 0.2)))
                }
                .tint(.black)
                .labelStyle(.iconOnly)
                .foregroundStyle(.orange)
                .font(.system(size: 18))
            }
            Spacer()
        }
        .padding(.trailing, 10)
    }
}
