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

        @Published private(set) var trip: Trip?
        
        
        @MainActor
        func getTripRequest(id: ObjectId) {
            do {
                self.trip  = try TripRepo.sharedTrip.getTripRequest(id: id)

                print("Trip FOUND! :: \(String(describing: trip))")
                
            } catch {
                print("error:: no trip request found  for id \(id)")
            }
        }
        
    }
}
