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
        
        
        func copyToClipBoard(text: String) {
            UIPasteboard.general.setValue(text,
                     forPasteboardType: UTType.plainText.identifier)
        }
        
        
    }
}
