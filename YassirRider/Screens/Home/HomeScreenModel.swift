import Foundation
import GoogleMaps
import SwiftUI
import RealmSwift

extension HomeScreen {
    class Model: ObservableObject {
        
        @Published var currentMarker = Marker(icon: "ic_user_location_pin", size: CGSize(width: 40, height: 50), marker: GMSMarker(position: LocationManager.shared.userLocation?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)))
        @Published var markersList = [Marker]()
        @ObservedObject var locationManager = LocationManager.shared
        
        func updateCurrentPosition() {
            if let coordinate = locationManager.userLocation?.coordinate {
                currentMarker.marker.position = coordinate
                currentMarker.marker.map?.animate(with: GMSCameraUpdate.setTarget(coordinate))
                currentMarker.marker.map?.animate(toZoom: 13.8)
            }
        }
        
        @MainActor
        func checkIsOnTrip() -> Bool {
            do {
                return try TripRepo.sharedTrip.checkisOnTrip()
            } catch {
                // Handle errors here
                print("Error occurred: \(error)")
                return false
            }
        }

    }
}
