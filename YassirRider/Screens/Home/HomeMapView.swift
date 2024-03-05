//
//  HomeMapView.swift
//  YassirRider
//
//  Created by Mac on 05/03/2024.
//

import Foundation
import SwiftUI

extension HomeScreen {
    struct Mapview: View {
        let currentMarker: Marker
        let markers: [Marker]
        
        var body: some View {
            MapViewControllerBridge(nearbyDrivers: markers, currentMarker: currentMarker)
        }
    }
}
