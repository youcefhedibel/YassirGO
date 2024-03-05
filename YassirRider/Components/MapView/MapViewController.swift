//
//  MapViewController.swift
//  GoRider
//
//  Created by Mac on 01/03/2024.
//

import GoogleMaps
import UIKit

public class MapViewController: UIViewController {
    
     let map =  GMSMapView(frame: .zero)
    
    public override func loadView() {
        super.loadView()
        self.view = map
    }
}
