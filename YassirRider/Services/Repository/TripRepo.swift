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
        func  getTripRequest(id: ObjectId) throws -> Trip {
            guard let trip = self.realm?.object(ofType: Trip.self, forPrimaryKey: id) else {return Trip()}
            return trip
        }
    
    
    @MainActor
    func createTripRequest(pickup: String, dropoff: String,price: Int, status: TripStatus) throws {
        let newTripRequest = Trip(pickup: pickup, dropoff: dropoff, price: price, driver: "samy", status: status)
        try self.write {
            self.trip = newTripRequest
            self.add(newTripRequest)
            print("rider created \(newTripRequest)")
        }
    }
}
