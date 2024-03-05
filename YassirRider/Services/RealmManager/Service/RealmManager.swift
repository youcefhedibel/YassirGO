//
//  RealmManager.swift
//  YassirRider
//
//  Created by Mac on 05/03/2024.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    
    static var shared = RealmManager()
    @Published var rider: Rider?
    
    private(set) var realm: Realm?
    
    @MainActor
    func initialize() async {
        
        do {
            guard var flexSyncConfig = app.currentUser?.flexibleSyncConfiguration() else { return }
            flexSyncConfig.objectTypes = [Rider.self]
            flexSyncConfig.schemaVersion = 0
            
            let realm = try await Realm(configuration: flexSyncConfig)
            
            
            let subscriptions = realm.subscriptions
            
            try await subscriptions.update {
                if let currentSubscription = subscriptions.first(named: "Rider") {
                    print("Replacing subscription for userDriver")
                    currentSubscription.updateQuery(toType: Rider.self)
                } else {
                    print("Appending subscription for userDriver")
                    subscriptions.append(QuerySubscription<Rider>(name: "Rider"))
                }
            }
            print("Successfully opened realm: \(realm)")
            
            self.realm = realm
            
            try self.getRider()
            
        } catch {
            print("Failed to open realm: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func login(email: String, password: String) async throws {
        let _ = try await app.login(credentials: .emailPassword(email: email, password: password))
        await initialize()
    }
    
    func signUp(fullname:String, email: String, password: String) async throws {
        try await app.emailPasswordAuth.registerUser(email: email, password: password)
        try await self.login(email: email, password: password)
        try await self.createRider(fullname: fullname)
    }
    
    @MainActor
    func createRider(fullname: String) throws {
        guard let id = app.currentUser?.id else { return }
        
        let newRider = Rider(id: id, fullname: fullname)
        
        try realm?.write {
            self.realm?.add(newRider)
            print("rider created \(newRider)")
        }
    }
    
    @MainActor
    func getRider() throws {
        guard let id = app.currentUser?.id else { return }
        
        self.rider = self.realm?.object(ofType: Rider.self, forPrimaryKey: id)
    }
    
}