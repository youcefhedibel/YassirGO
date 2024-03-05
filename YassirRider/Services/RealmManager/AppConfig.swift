import Foundation
import RealmSwift


struct AppConfig {
    var appId: String
    var baseUrl: String
    var atlasUrl: String?
}

func loadAppConfig() -> AppConfig {
    guard let path = Bundle.main.path(forResource: "AtlasConfig", ofType: "plist") else {
        fatalError("Could not load atlasConfig.plist file!")
    }

    let data = NSData(contentsOfFile: path)! as Data
    let atlasConfigPropertyList = try! PropertyListSerialization.propertyList(from: data, format: nil) as! [String: Any]
    let appId = atlasConfigPropertyList["appId"]! as! String
    let baseUrl = atlasConfigPropertyList["baseUrl"]! as! String

    let atlasUrl = atlasConfigPropertyList["dataExplorerLink"]
    if let atlasUrl = atlasUrl {
        return AppConfig(appId: appId, baseUrl: baseUrl, atlasUrl: atlasUrl as? String)
    } else {
        return AppConfig(appId: appId, baseUrl: baseUrl, atlasUrl: nil)
    }
}
