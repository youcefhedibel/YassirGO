//
//  Trip.swift
//  YassirRider
//
//  Created by Mac on 06/03/2024.
//

import Foundation
import RealmSwift

class Trip: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var pickup: String
    
    @Persisted var dropoff: String
    
    @Persisted var price: Int
    
    @Persisted var  driver: String
    
    @Persisted var status: TripStatus
    
    convenience init(pickup: String, dropoff: String, price: Int, driver: String, status: TripStatus) {
        self.init()
        self._id = .generate()
        self.pickup = pickup
        self.dropoff = dropoff
        self.price = price
        self.driver = driver
        self.status = status
    }
}

enum TripStatus: String, PersistableEnum {
    case idle
    case pending
    case accepted
    case arrivedDriver
    case toDestination
    case arrivedDestination 
}
