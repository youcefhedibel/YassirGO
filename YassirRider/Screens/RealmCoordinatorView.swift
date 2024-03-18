//
//  RealmCoordinatorView.swift
//  YassirRider
//
//  Created by Mac on 05/03/2024.
//

import Foundation
import SwiftUI
import RealmSwift

struct OpenRealmView: View {
    
    @ObservedObject var rider: Rider


    @AutoOpen(appId: app.appId, timeout: 2000) var autoOpen
    var body: some View {
        switch autoOpen {
        case .connecting:
            ProgressView().onAppear{ print("connecting") }
            
        case .waitingForUser:
            ProgressView("Waiting for user to log in...").onAppear{ print("waitingForUser") }
            
        case .open( _):
            HomeScreen(rider: rider).onAppear{ print("open") }
            
        case .progress(let progress):
            ProgressView(progress).onAppear{ print("progress") }
        case .error( _):
            
            EmptyView().onAppear{ print("error") }
        }
    }
}

