//
//  Driver.swift
//  App
//
//  Created by Samy Mehdid on 4/3/2024.
//

import Foundation
import RealmSwift

class Driver: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var _id: String
    
    @Persisted var fullname: String
    
    @Persisted var tripRequestId: ObjectId?
    
    @Persisted var currentTripId: ObjectId?
    
    @Persisted var isOnline: Bool
    
    @Persisted var revenue: Int
    
    @Persisted var profileImageUrl: String?
    
    @Persisted var phoneNumber: String
    
    @Persisted var rating: Double
    
    @Persisted var trips: List<Trip>
    
    convenience init(id: String, fullname: String) {
        self.init()
        self._id = id
        self.fullname = "samy"
        self.tripRequestId = nil
        self.currentTripId = nil
        self.isOnline = false
        self.revenue = 0
        self.profileImageUrl = nil
        self.phoneNumber = "+213540408051"
        self.rating = 5
    }
}
