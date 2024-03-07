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
    
    convenience init(id: String, fullname: String) {
        self.init()
        self._id = id
        self.fullname = fullname
    }
}
