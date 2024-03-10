//
//  YassirRiderApp.swift
//  YassirRider
//
//  Created by Mac on 05/03/2024.
//

import SwiftUI
import GoogleMaps
import RealmSwift

let theAppConfig = loadAppConfig()

let atlasUrl = theAppConfig.atlasUrl

let app = App(id: theAppConfig.appId, configuration: AppConfiguration(baseURL: theAppConfig.baseUrl, transport: nil))



@main
struct YassirRiderApp: SwiftUI.App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                LocationManager.shared.requestLocation()
            }
        }
    }
}
