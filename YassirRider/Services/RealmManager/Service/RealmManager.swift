//
//  RealmManager.swift
//  YassirRider
//
//  Created by Mac on 05/03/2024.
//

import Foundation
import RealmSwift
import Realm

class RealmManager: ObservableObject {
    
    static var shared = RealmManager()
    
    private(set) var realm: Realm?
    
    @MainActor
    func initialize() async {
        
        do {
            guard var flexSyncConfig = app.currentUser?.flexibleSyncConfiguration() else { return }
            flexSyncConfig.objectTypes = [Rider.self, Trip.self]
            flexSyncConfig.schemaVersion = 0
            
            var realm = try await Realm(configuration: flexSyncConfig)
            
            try await realm.setSubscriptions()
            
            print("Successfully opened realm: \(realm)")
            
            self.realm = realm
            
            await RiderRepo.sharedRider.getRider()
            
        } catch {
            print("Failed to open realm: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func write<Result>(_ block: (() throws -> Result)) throws {
        
        if let realm = self.realm {
            try realm.write(block)
        } else {
            print("could not write the object")
        }
    }
    
    @MainActor
    func get<Element, KeyType>(
        ofType type: Element.Type,
        forPrimaryKey key: KeyType
    ) -> Element? where Element : RealmSwiftObject {
        if let realm = self.realm {
            return realm.object(ofType: type, forPrimaryKey: key)
        } else {
            return nil
        }
    }
    
    @MainActor
    func add(_ object: Object) {
        if let realm = self.realm {
            realm.add(object)
            print("add object")
        }
        print("could not add object")
    }
}
