//
//  ConfigManager.swift
//  YassirRider
//
//  Created by Mac on 10/03/2024.
//


import Foundation
import RealmSwift

var app: App {
    return App(
        id: ConfigManager.shared.appConfig.appId,
        configuration: AppConfiguration(
            baseURL: ConfigManager.shared.appConfig.baseUrl,
            transport: nil
        )
    )
}



fileprivate class ConfigManager {
    
    struct AppConfig {
        var appId: String
        var baseUrl: String
    }
    
    static let shared = ConfigManager()
    
    var appConfig: AppConfig {
        return loadAppConfig()
    }
    
    init() {  }
    
    private func loadAppConfig() -> AppConfig {
        
        guard let path = Bundle.main.path(forResource: "AtlasConfig", ofType: "plist") else {
            fatalError("Could not load atlasConfig.plist file!")
        }
        
        let data = NSData(contentsOfFile: path)! as Data
        let atlasConfigPropertyList = try! PropertyListSerialization.propertyList(from: data, format: nil) as! [String: Any]
        let appId = atlasConfigPropertyList["appId"]! as! String
        let baseUrl = atlasConfigPropertyList["baseUrl"]! as! String

        return AppConfig(appId: appId, baseUrl: baseUrl)
    }
}
