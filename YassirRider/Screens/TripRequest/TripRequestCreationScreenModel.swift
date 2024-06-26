//
//  TripRequestCreationScreenModel.swift
//  YassirRider
//
//  Created by Mac on 06/03/2024.
//

import Foundation
import RealmSwift

extension TripRequestCreation {
    class Model: ObservableObject {
        
        @Published var trip: Trip?
        
        @MainActor
        func createTripRequest(pickup: String, dropoff: String, price: Int, status: TripStatus) {
            Task {
                do {
                    try await self.trip = TripRepo.sharedTrip.createTripRequest(pickup: pickup, dropoff: dropoff, price: price, status: status)
                    
                    try await DriverRepo.sharedDriver.asignTripToDriver(tripId: self.trip?._id ?? ObjectId("65f0"))
                } catch {
                    print("Error creating trip: \(error)")
                }
            }
        }
        
    }
}
