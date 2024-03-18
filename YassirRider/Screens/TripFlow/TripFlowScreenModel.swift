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
                    print("Error canceling trip: \(error)")
                }
            }
        }
    }
}
