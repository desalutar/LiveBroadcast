//
//  MapView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 13.06.24.
//

import SwiftUI
import MapKit

struct MapView: View {
    var body: some View {
        ZStack {
            Map {
                Marker(coordinate: CLLocationCoordinate2D.moscowCity) {
                    Text("Moscow City")
                }
            }
            MapViewButtons()
        }
    }
}


extension CLLocationCoordinate2D {
    static let moscowCity = CLLocationCoordinate2D(latitude: 55.75222, longitude:  37.61556)
}
#Preview {
    MapView()
}

