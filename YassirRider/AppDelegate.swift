//
//  AppDelegate.swift
//  YassirRider
//
//  Created by Mac on 05/03/2024.
//

import Foundation
import UIKit
import GoogleMaps

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
         
        GMSServices.provideAPIKey("AIzaSyC_BQ9OQQUIQVUvEEyMG7apcd3bOe-X_VA")
        
        return true
    }
}
