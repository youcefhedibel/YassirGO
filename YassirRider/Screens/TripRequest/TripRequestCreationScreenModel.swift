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
        
        @MainActor
        func createTripRequest(pickup: String, dropoff: String, price: Int, status: TripStatus) {
            do {
                try realmManager.createTripRequest(pickup: pickup, dropoff: dropoff, price: price, status: status)
            } catch {
                print(error.localizedDescription)
            }
        }
        
//        @MainActor
//        func getTripRequest(){
//            do {
//                self.tripRequest = try realmManager.getTripRequest()
//                print("TRRRIPP REQUEST  \(tripRequest)")
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
        
    }
}
