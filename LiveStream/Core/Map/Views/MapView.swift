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
            Map(position: $cameraPositionOnMap) {
                
            }
            .mapControls({
                MapUserLocationButton()
            })
            .onAppear {
                CLLocationManager().requestWhenInUseAuthorization()
            }
            .mapStyle(.imagery(elevation: .realistic))
            //                .sheet(isPresented: $showActionSheet, content: {
            //                        Text("Hello")
            //                    .presentationDetents(
            //                        [
            //                            .fraction(0.2),
            //                            .height(300),
            //                            .fraction(0.5),
            //                            .height(600)
            //                        ]
            //                    )
            //                })
        }
    }
}


extension CLLocationCoordinate2D {
    static let moscowCity = CLLocationCoordinate2D(latitude: 55.75222, longitude:  37.61556)
}
#Preview {
    MapView()
}

