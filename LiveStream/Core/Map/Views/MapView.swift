//
//  MapView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 13.06.24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var showActionSheet = true
    @State private var cameraPositionOnMap: MapCameraPosition = .userLocation(fallback: .automatic)
    @ObservedObject private var locationManager = LocationManager()
    
    var body: some View {
        ZStack {
            GlobeMapView(coordinate: .moscowCity)
                .ignoresSafeArea()
                .onAppear {
                    locationManager.requestLocation()
                    
                    CLLocationManager().requestWhenInUseAuthorization()
                }
        }
        
    }
}


extension CLLocationCoordinate2D {
    static let moscowCity = CLLocationCoordinate2D(latitude: 55.75222, longitude:  37.61556)
}
#Preview {
    MapView()
}

