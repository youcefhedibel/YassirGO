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
    @AutoOpen(appId: theAppConfig.appId, timeout: 2000) var autoOpen
    var body: some View {
        switch autoOpen {
        case .connecting:
            ProgressView().onAppear{ print("connecting") }
            
        case .waitingForUser:
            ProgressView("Waiting for user to log in...").onAppear{ print("waitingForUser") }
            
        case .open(let realm):
            HomeScreen().onAppear{ print("open") }
            
        case .progress(let progress):
            ProgressView(progress).onAppear{ print("progress") }
        case .error(let error):
            
            EmptyView().onAppear{ print("error") }
        }
    }
}
