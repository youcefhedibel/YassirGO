//
//  YassirButton.swift
//  GoRider
//
//  Created by Mac on 01/03/2024.
//

import Foundation
import SwiftUI


public struct YassirButton<Content: View>: View {
    private let content: () -> Content
    private let action: () -> Void
    private let disabled: Bool
    private let radius: Double
    private let elevation: Double
    
    
    public init(disabled: Bool = false, radius: Double = 27, elevation: Double = 0.5, @ViewBuilder content: @escaping () -> Content, action: @escaping () -> Void){
        self.content = content
        self.action = action
        self.disabled = disabled
        self.radius = radius
        self.elevation = elevation
    }
    
    public var body: some View {
        Button(action: self.action, label: self.content)
            .disabled(self.disabled)
            .frame(maxWidth: .infinity, maxHeight: 55)
            .cornerRadius(radius)
            .background(RoundedRectangle(cornerRadius: radius)
            .fill(disabled ? Color.disabledButton : Color.primaryColor)
            .shadow(radius: elevation))
    }
}
