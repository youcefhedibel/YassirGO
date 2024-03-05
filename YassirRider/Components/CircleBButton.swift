//
//  CircleBButton.swift
//  GoRider
//
//  Created by Mac on 02/03/2024.
//

import Foundation
import SwiftUI


public struct CircleButton: View {
    let image: Image
    let tint: Color
    let color: Color
    let action: () -> Void
    
    public init(image: Image, tint: Color, color: Color = .white, action: @escaping () -> Void) {
        self.image = image
        self.action = action
        self.color = color
        self.tint = tint
    }
    
    public var body: some View {
        Button(action: action, label: {
            ZStack{
                image
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(tint)
                    .frame(width: 27, height: 27, alignment: .center)
            }
            .frame(width: 50, height: 50)
            .foregroundColor(.black)
            .clipShape(Circle())
            .background(Circle().fill(color).shadow(color: .black.opacity(0.1), radius: 5))
        })
    }
}
