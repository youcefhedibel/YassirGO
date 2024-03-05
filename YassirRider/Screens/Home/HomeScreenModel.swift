//
//  HomeScreenModel.swift
//  YassirRider
//
//  Created by Mac on 05/03/2024.
//
import Foundation
import GoogleMaps
import SwiftUI

extension HomeScreen {
    class Model: ObservableObject {
        
        @Published var currentMarker = Marker(icon: "ic_user_location_pin", size: CGSize(width: 40, height: 50), marker: GMSMarker(position: LocationManager.shared.userLocation?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)))
        @Published var markersList = [Marker]()
        @ObservedObject var locationManager = LocationManager.shared

        
        func updateCurrentPosition() {
            if let cooridnate = locationManager.userLocation?.coordinate {
                currentMarker.marker.position = cooridnate
                currentMarker.marker.map?.animate(with: GMSCameraUpdate.setTarget(cooridnate))
                currentMarker.marker.map?.animate(toZoom: 13.8)
            }
        }

        
    }
}
