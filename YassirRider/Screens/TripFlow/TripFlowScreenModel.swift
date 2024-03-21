//
//  TripFlowScreenModel.swift
//  YassirRider
//
//  Created by Mac on 07/03/2024.
//

import Foundation
import RealmSwift

extension  TripFlowScreen {
    class Model: ObservableObject {
        
        @MainActor
        func cancelTrip(tripID: ObjectId) {
            Task {
                do {
                    try await TripRepo.sharedTrip.cancelTrip(id: tripID)
                } catch {
                    print("Error::canceling::trip: \(error)")
                }
            }
        }
        
        @MainActor
        func completeTrip(tripID: ObjectId) {
            Task {
                do {
                    try await TripRepo.sharedTrip.completeTrip(id: tripID)
                } catch {
                    print("Error::completing::trip::\(error)")
                }
            }
        }
        
        @MainActor
        func rateDriver(stars: Int) {
            Task {
                do {
                    try await DriverRepo.sharedDriver.rateDriver(stars: stars)
                } catch {
                    print("Error::rating::driver::\(error)")
                    
                }
            }
        }
        
        
    }
}
