//
//  NavigationButton.swift
//  YassirRider
//
//  Created by Mac on 13/03/2024.
//

import Foundation
import SwiftUI

struct NavigationButton<Destination: View, Label: View>: View {
    var action: () -> Void = {}
    var destination: () -> Destination
    var label: () -> Label
    private let disabled: Bool
    @State private var isLinkActive = false

     
     init(disabled: Bool, destination: @escaping () -> Destination, label: @escaping () -> Label, action: @escaping () -> Void = {}) {
         self.disabled = disabled
         self.destination = destination
         self.label = label
         self.action = action
     }
    
    var body: some View {
        Button(action: {
            self.action()
            self.isLinkActive.toggle()
            
        }) {
            self.label()
            NavigationLink(destination: self.destination(), isActive: $isLinkActive) {
                EmptyView()
            }
        }.disabled(disabled)
    }
}
