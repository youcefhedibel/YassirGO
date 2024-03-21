//
//  MapViewControllerBridge.swift
//  GoRider
//
//  Created by Mac on 01/03/2024.
//

import GoogleMaps
import SwiftUI

public struct Marker {
    var icon: String
    var size: CGSize
    public let marker: GMSMarker
    
    public init(icon: String, size: CGSize = CGSize(width: 20, height: 20), marker: GMSMarker) {
        self.icon = icon
        self.size = size
        self.marker = marker
    }
}

public struct MapViewControllerBridge: UIViewControllerRepresentable {
    
    private var markers: [Marker]?
    private var currentMarker: Marker?

    private var cameraPosition: CLLocationCoordinate2D?
    private var centerToCameraPosition: Bool?
    private var zoom: Float = 13.8
    
    private var overviewPoints: String?
    
    private var mapViewWillMove: ((Bool, CLLocationCoordinate2D) -> ())?
    
    
    /// mapview initializer for homeView
    public init(nearbyDrivers: [Marker], currentMarker: Marker, zoom: Float = 12) {
        self.markers = nearbyDrivers
        self.currentMarker = currentMarker
        self.cameraPosition = currentMarker.marker.position
        self.zoom = zoom
    }
    
    public func makeUIViewController(context: Context) -> MapViewController {
        let uiViewController = MapViewController()
        uiViewController.map.delegate = context.coordinator
        
        if let cameraPosition = cameraPosition, overviewPoints == nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                uiViewController.map.animate(with: GMSCameraUpdate.setTarget(cameraPosition))
                uiViewController.map.animate(toZoom: zoom)
            }
        } else {
            var bounds = GMSCoordinateBounds()
            if let markers = markers {
                for marker in markers {
                    bounds = bounds.includingCoordinate(marker.marker.position)
                    withAnimation {
                        let update = GMSCameraUpdate.fit(bounds, withPadding: 100.0)
                        uiViewController.map.animate(with: update)
                    }
                }
            }
        }
        
        if let overviewPoints = overviewPoints {
            let path = GMSPath(fromEncodedPath: overviewPoints)
            let directionPolyline = GMSPolyline(path: path)
            directionPolyline.strokeColor = UIColor.black
            directionPolyline.strokeWidth = 4
            directionPolyline.map = uiViewController.map
        }
        
        /// mapStyle
        do {
           
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                uiViewController.map.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        /// function return
        return uiViewController
    }
    
    public func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        
        if let currentMarker = currentMarker {
            let icon = UIImage(named: currentMarker.icon)
            let iconImage = UIImageView(image: icon)
            iconImage.frame = CGRect(x: 0, y: 0, width: currentMarker.size.width, height: currentMarker.size.height)
            currentMarker.marker.iconView = iconImage
            currentMarker.marker.map = uiViewController.map
        }
        
        if let markers = markers {
            for marker in markers {
                let icon = UIImage(named: marker.icon)
                let iconImage = UIImageView(image: icon)
                iconImage.frame = CGRect(x: 0, y: 0, width: marker.size.width, height: marker.size.height)
                marker.marker.iconView = iconImage
                
                marker.marker.map = uiViewController.map
            }
        }
        
        if centerToCameraPosition == true, let cameraPosition = cameraPosition {
            uiViewController.map.animate(with: GMSCameraUpdate.setTarget(cameraPosition))
            uiViewController.map.animate(toZoom: zoom)
        }
    }
    
    public func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(self)
    }
    
    public final class MapViewCoordinator: NSObject, GMSMapViewDelegate {
        var mapViewControllerBridge: MapViewControllerBridge
        
        init(_ mapViewControllerBridge: MapViewControllerBridge) {
            self.mapViewControllerBridge = mapViewControllerBridge
        }
        
        public func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
            if nil != self.mapViewControllerBridge.mapViewWillMove {
                self.mapViewControllerBridge.mapViewWillMove!(gesture, mapView.camera.target)
            }
        }
        
        public func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            if nil != self.mapViewControllerBridge.mapViewWillMove {
                self.mapViewControllerBridge.mapViewWillMove!(false, position.target)
            }
        }
    }
}
