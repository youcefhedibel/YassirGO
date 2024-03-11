//
//  ContentView.swift
//  YassirRider
//
//  Created by Mac on 05/03/2024.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @StateObject private var realmManager = RealmManager.shared
    @StateObject private var riderManager = RiderRepo.sharedRider
    var body: some View {
        if let _ = app.currentUser {
            ZStack{

                if let rider = riderManager.rider,
                   nil != realmManager.realm {
                    Text("CONTENT VIEW22")
                    OpenRealmView(rider: rider)
                }
            }
            .task{  await realmManager.initialize() }
        } else {
            LoginScreen()
        }
    }
    
    private func runTasks() async {
        await realmManager.initialize()
    }
}
