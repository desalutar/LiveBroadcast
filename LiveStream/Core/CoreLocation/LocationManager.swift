//
//  LocationManager.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 13.06.24.
//

import Foundation
import CoreLocation
import CoreLocationUI
import MapKit
import _MapKit_SwiftUI

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var currentCoordinate: CLLocationCoordinate2D?
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
    }
    
    func startCurrentLocationUpdates() async throws {
            for try await locationUpdate in CLLocationUpdate.liveUpdates() {
                guard let location = locationUpdate.location else { return }

                self.location = location
            }
        }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        self.currentCoordinate = location.coordinate
    }
    
    func locationManager(_
                         manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus
    ) {
        
    }
}
