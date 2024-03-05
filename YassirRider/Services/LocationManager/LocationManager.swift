//
//  LocationManager.swift
//  GoRider
//
//  Created by Mac on 01/03/2024.
//

import Foundation
import CoreLocation

enum LocationState {
    case loading
    case loaded(CLAuthorizationStatus)
    case failed(fixable: Bool)
}

@available(iOS 13.0, *)
public class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    
    @Published public var userLocation: CLLocation?
    @Published public var status: CLAuthorizationStatus?
    
    public static let shared = LocationManager()
    
    public override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    
    public func requestLocation() {
        manager.requestWhenInUseAuthorization()
    }
    
    public func setBackgroundModeOnOff(_ value: Bool){
        manager.allowsBackgroundLocationUpdates = value
        manager.showsBackgroundLocationIndicator = value
    }
}

@available(iOS 13.0, *)
extension LocationManager: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
        switch status {
        case .notDetermined:
            print("not determined")
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways, .authorizedWhenInUse:
            print("location should be shown")
        default:
            break
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.userLocation = location
    }
}
