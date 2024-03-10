//
//  RiderRepo.swift
//  YassirRider
//
//  Created by Mac on 10/03/2024.
//

import Foundation
import RealmSwift

class RiderRepo: RealmManager {
    
    static let sharedRider = RiderRepo()
    
    @Published private(set) var rider: Rider?
    
    
    @MainActor
    func getRider() async {
        
        guard let realm = self.realm else {
            await initialize()
            return
        }
        
        guard let id = app.currentUser?.id else {
            return
        }
        
        self.rider = realm.object(ofType: Rider.self, forPrimaryKey: id)
        print(" RIDER ID \(id)")
        debugPrint("this is rider: " + rider.debugDescription)
    }
    
    @MainActor
    func createRider(fullname: String) async throws {
        
        await self.initialize()
        
        guard let id = app.currentUser?.id else {
            print("createRider:: NO ID FOUND")
            return
        }
        
        let newRider = Rider(id: id, fullname: fullname)
        
        try self.write {
            self.rider = newRider
            self.add(newRider)
            print("rider created \(newRider)")

        }
    }
    
    
    @MainActor
    func assignTripRequest(_ id: ObjectId) throws {
        try self.write {
            self.rider?.currentTripId = id
        }
    }
    
}
