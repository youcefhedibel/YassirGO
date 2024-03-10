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
        
        let realmManager = RealmManager.shared
        @Published var trip: Trip?
        
        @MainActor
        func createTripRequest(pickup: String, dropoff: String, price: Int, status: TripStatus) {
            do {
                
                try TripRepo.sharedTrip.createTripRequest(pickup: pickup, dropoff: dropoff, price: price, status: status)
                
            } catch {
                print(error.localizedDescription)
            }
        }
        
        
    }
}
