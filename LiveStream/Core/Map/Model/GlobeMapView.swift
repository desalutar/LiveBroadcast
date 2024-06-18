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
        let globeMap = MKMapView()
        globeMap.delegate = context.coordinator
        globeMap.preferredConfiguration = MKImageryMapConfiguration(elevationStyle: .realistic)
        
        let mapCamera = MKMapCamera()
        mapCamera.centerCoordinate = coordinate
        mapCamera.centerCoordinateDistance = 37456780
        globeMap.setCamera(mapCamera, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        globeMap.addAnnotation(annotation)
        return globeMap
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    typealias UIViewType = MKMapView
}
