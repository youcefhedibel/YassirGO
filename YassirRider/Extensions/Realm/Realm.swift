//
//  Realm.swift
//  YassirRider
//
//  Created by Mac on 10/03/2024.
//

import Foundation
import RealmSwift

extension Realm {
    mutating func setSubscriptions() async throws {
        
        let subscriptions = self.subscriptions
        
        try await subscriptions.update {
            subscriptions.checkAndSet(subKey: "Trip", model: Trip.self)
            subscriptions.checkAndSet(subKey: "Rider", model: Rider.self)
            subscriptions.checkAndSet(subKey: "Driver", model: Driver.self)
        }
    }
}

