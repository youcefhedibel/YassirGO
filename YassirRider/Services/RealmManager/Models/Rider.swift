//
//  Rider.swift
//  YassirRider
//
//  Created by Mac on 05/03/2024.
//

import Foundation
import RealmSwift

class Rider: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: String
    
    @Persisted var fullname: String
    
    @Persisted var currentTripId: ObjectId?
    
    @Persisted var profileImageUrl: String?
    
    @Persisted var phoneNumber: String
    
    @Persisted var trips: List<Trip>

    convenience init(id: String, fullname: String) {
        self.init()
        self._id = id
        self.fullname = fullname
        self.profileImageUrl = nil
        self.phoneNumber = "0791892621"
    }
}
