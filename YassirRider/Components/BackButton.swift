//
//  BackButton.swift
//  GoRider
//
//  Created by Mac on 02/03/2024.
//

import Foundation
import SwiftUI


public struct BackButton: View {
    let action: () -> Void
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        Button(action: action, label: {
            Image("icon-back")
                .resizable()
                .frame(width: 18, height: 12)
        }).frame(width: 50, height: 50)
            .foregroundColor(.black)
            .clipShape(Circle())
            .background(Circle().fill(Color.white).shadow(color: .black.opacity(0.1), radius: 3))
    }
}
