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
        
        let newTrip = Trip(pickup: pickup, dropoff: dropoff, price: price, driver: "samy", status: status)
        
        do {
            try realm.write {
                realm.add(newTrip)
            }
            print("trip request created ! \(newTrip)")
            self.trip = newTrip
            return newTrip
        } catch {
            throw error
        }
    }
        
        @MainActor
        func  getTripRequest(id: ObjectId) throws -> Trip {
            guard let trip = RealmManager.shared.realm?.object(ofType: Trip.self, forPrimaryKey: id) else { return Trip() }
            self.trip = trip
            return trip
        }
        
    }

