//
//  TripRepo.swift
//  YassirRider
//
//  Created by Mac on 10/03/2024.
//

import Foundation
import RealmSwift
import Realm

class TripRepo: RealmManager {
    
    static let sharedTrip = TripRepo()
    
    @Published private(set) var trip: Trip?
    
    @MainActor
    func createTripRequest(pickup: String, dropoff: String, price: Int, status: TripStatus) async throws -> Trip {

        guard let realm = RealmManager.shared.realm else {
            throw NSError(domain: "Realm not initialized", code: 0, userInfo: nil)
        }
        
        let newTrip = Trip(pickup: pickup, dropOff: dropoff, price: price, status: status)
        
        do {
            try RiderRepo.sharedRider.assignTripRequest(trip: newTrip)
            try realm.write {
                realm.add(newTrip)
                print("trip request created ! \(newTrip)")
            }
            self.trip = newTrip
            return newTrip
        } catch {
            throw error
        }
    }
        
    @MainActor
    func  getTripRequest(id: ObjectId) throws {
        guard let trip = RealmManager.shared.realm?.object(ofType: Trip.self, forPrimaryKey: id) else { return }
        self.trip = trip
    }
    
    @MainActor
    func cancelTrip(id: ObjectId) async throws {
        
        guard let realm = RealmManager.shared.realm else {
            throw NSError(domain: "Realm not initialized", code: 0, userInfo: nil)
        }
        
        guard let trip = realm.object(ofType: Trip.self, forPrimaryKey: id) else { return }
        
        try  realm.write {
            trip.status = .canceled
            self.trip = nil
            debugPrint("Trip canceled:: ID:: \(id)")
            
        }
    }

    
    }

