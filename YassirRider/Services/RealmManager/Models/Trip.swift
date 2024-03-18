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
    
    @Persisted var status: TripStatus
    
    @Persisted var price: Int
    
    @Persisted var pickup: String
    
    @Persisted var dropOff: String
    
    @Persisted var category: Trip.Category
    
    @Persisted var createdAt: Date
    
    @Persisted var updatedAt: Date
    
    @Persisted(originProperty: "trips") var rider: LinkingObjects<Rider>
    
    @Persisted(originProperty: "trips") var driver: LinkingObjects<Driver>
    
    convenience
    init( pickup: String, dropOff: String, price: Int, status: TripStatus) {
        self.init()
        self._id = .generate()
        self.pickup = pickup
        self.dropOff = dropOff
        self.price = price
        self.createdAt = .now
        self.updatedAt = .now
        self.status = status
        self.category = .classic
    }

}

enum TripStatus: String, PersistableEnum {
    case pending
    case accepted
    case toClient
    case arrivedClient
    case toDestination
    case arrivedDestination
    case canceled
    case completed
}

extension Trip {
    enum Category: String, PersistableEnum {
        case classic
        case business
    }
}
