//
//  SyncSubscriptionSet.swift
//  YassirRider
//
//  Created by Mac on 10/03/2024.
//

import Foundation
import RealmSwift
import Realm


extension SyncSubscriptionSet {
    func checkAndSet<Model: Object>(subKey: String, model: Model.Type) {
        if let selfSub = self.first(named: subKey) {
            print("Replacing subscription for \(subKey)")
            selfSub.updateQuery(toType: Model.self)
        } else {
            print("Appending subscription for \(subKey)")
            self.append(QuerySubscription<Model>(name: subKey))
        }
    }
}


