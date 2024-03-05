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

    var body: some View {
        if let _ = app.currentUser {
            ZStack{
                if let rider = realmManager.rider,
                   nil != realmManager.realm {
                    OpenRealmView()
                }
            }
            .task{ await realmManager.initialize() }
        } else {
            LoginScreen()
        }
    }
}
