//
//  SimpleMapView.swift
//  LiveStream
//
//  Created by Ишхан Багратуни on 15.06.24.
//
import SwiftUI
import MapKit

struct GlobeMapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: GlobeMapView

        init(parent: GlobeMapView) {
            self.parent = parent
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.mapType = .satelliteFlyover

        let camera = MKMapCamera()
        camera.centerCoordinate = coordinate
        camera.altitude = 33456780
        mapView.setCamera(camera, animated: true)
        
        mapView.showsBuildings = false
        mapView.showsCompass = false
        mapView.showsScale = false
        mapView.pointOfInterestFilter = .includingAll

        // Добавляем метку
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Обновление карты при необходимости
    }

    typealias UIViewType = MKMapView
}
