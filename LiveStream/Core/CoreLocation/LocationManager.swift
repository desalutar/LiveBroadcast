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
    @Published var locationName = " "
    
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
    }
    
    func startCurrentLocationUpdates() async throws {
            for try await locationUpdate in CLLocationUpdate.liveUpdates() {
                guard let location = locationUpdate.location else { return }
                self.location = location
            }
    }
    
    func fetchLocationName(for coordinate: CLLocationCoordinate2D) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude,
                                  longitude: coordinate.longitude)
        
        geoCoder.reverseGeocodeLocation(location) { places, error in
            if let error = error {
                print("Failed to reverse geocode location: \(error)")
                self.locationName = "Planet Earth"
                return
            }
            
            guard let placemark = places?.first else {
                self.locationName = "Planet Earth"
                print("No placemarks found")
                return
            }
            
            if let city = placemark.locality ?? placemark.administrativeArea {
                self.locationName = city
            } else {
                self.locationName = "Planet Earth"
            }
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
