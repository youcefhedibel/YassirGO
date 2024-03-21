//
//  ProfileScreenModel.swift
//  YassirRider
//
//  Created by Mac on 19/03/2024.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers


extension ProfileScreen {
    class Model: ObservableObject {
        
        @MainActor
        func updateProfile(fullName: String?, phone: String?) {
            do {
                try RiderRepo.sharedRider.updateProfile(fullName: fullName, phone: phone)
            } catch {
                print("error::updateProfile")
            }
        }
        
        @MainActor
        func logout() {
            LoginRepo.sharedLogin.loggout()
        }
        
        func copyToClipBoard(text: String) {
            UIPasteboard.general.setValue(text,
                                          forPasteboardType: UTType.plainText.identifier)
        }
        
        
    }
}
