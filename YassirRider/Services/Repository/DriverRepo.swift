//
//  DriverRepo.swift
//  YassirRider
//
//  Created by Mac on 11/03/2024.
//

import Foundation
import RealmSwift
import Realm

class DriverRepo: RealmManager {
    
    static let sharedDriver = DriverRepo()
    
    @Published private(set) var driver: Driver?
    
    @MainActor
    func getDriver() async  -> Driver {
        
        guard let realm = RealmManager.shared.realm else {
            await RealmManager.shared.initialize()
            return Driver()
        }
        
        guard let driver = realm.object(ofType: Driver.self, forPrimaryKey: "65f2e02632da5192dc54b195")  else {
            print("NO DRIVER FOUND !!")
            return Driver()}
        print("GET DRIVER::: \(driver)")
        return driver
    }
    
    @MainActor
    func asignTripToDriver(tripId: ObjectId) async throws {
        
        guard let realm = RealmManager.shared.realm else {
            throw NSError(domain: "Realm not initialized", code: 0, userInfo: nil)
        }
        
        do {
            try realm.write {
                self.driver = realm.object(ofType: Driver.self, forPrimaryKey: "65f2e02632da5192dc54b195")
                self.driver?.tripRequestId =  tripId
            }
            print("asignTripToDriver ! \(String(describing: driver))")
            
        } catch {
            throw error
        }
    }
    
    @MainActor
    func rateDriver(stars: Int) async throws {
        guard let realm = RealmManager.shared.realm else {
            throw NSError(domain: "Realm not initialized", code: 0, userInfo: nil)
        }
        
        do {
            try realm.write {
                self.driver = realm.object(ofType: Driver.self, forPrimaryKey: "65f2e02632da5192dc54b195")
                self.driver?.rating =  Double(stars)
            }
            print("driver::rated::with\(stars)::stars")
            
        } catch {
            throw error
        }
    }
    

    
}

