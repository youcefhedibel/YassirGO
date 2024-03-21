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
        
        guard let realm = RealmManager.shared.realm else {
            await RealmManager.shared.initialize()
            return
        }
        
        guard let id = app.currentUser?.id else {
            return
        }
        
        self.rider = realm.object(ofType: Rider.self, forPrimaryKey: id)
        
        debugPrint("rider::found::" + rider.debugDescription)
    }
    
    @MainActor
    func createRider(fullname: String) async throws {
        
        await RealmManager.shared.initialize()
        
        guard let id = app.currentUser?.id else {
            print("createRider::NO::ID::FOUND")
            return
        }
        
        let newRider = Rider(id: id, fullname: fullname)
        
        try RealmManager.shared.write {
            self.rider = newRider
            RealmManager.shared.add(newRider)
            print("rider::created::\(newRider)")
            
        }
    }
    
    
    @MainActor
    func assignTripRequest(trip: Trip) throws {
        try RealmManager.shared.write {
            self.rider?.trips.append(trip)
        }
    }
    
    @MainActor
    func updateProfile(fullName: String?, phone: String?) throws {
        if let fullName = fullName {
            try RealmManager.shared.write {
                self.rider?.fullname = fullName
            }
        }
        
        if let phone = phone {
            try  RealmManager.shared.write {
                self.rider?.phoneNumber = phone
            }
        }
    }
    
    
}
