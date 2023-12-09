//
//  MapView.swift
//  ShareSpace-personal project
//
//  Created by 任非凡 on 12/9/23.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @ObservedObject var locationManager = LocationManager()
    @Binding var selectedCoordinate: CLLocationCoordinate2D?
    @Binding var isShowingDetailView: Bool

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        context.coordinator.addLongPressGesture(to: mapView)
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let location = locationManager.currentLocation {
            let region = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            uiView.setRegion(region, animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func addLongPressGesture(to mapView: MKMapView) {
            let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
            longPressGesture.minimumPressDuration = 1.0 // Adjust this value for the desired press duration
            mapView.addGestureRecognizer(longPressGesture)
        }

        @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
            if gesture.state == .began {
                let point = gesture.location(in: gesture.view)
                if let mapView = gesture.view as? MKMapView {
                    let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    mapView.addAnnotation(annotation)
                    
                    DispatchQueue.main.async {
                        self.parent.selectedCoordinate = coordinate  // Directly assign the value
                        self.parent.isShowingDetailView = true  // Directly assign the value
                    }
                }
            }
        }

    }
}




