//
//  BackButton.swift
//  GoRider
//
//  Created by Mac on 02/03/2024.
//

import Foundation
import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let text: String
    let textColor: Color
    let font: Font.YassirRubik
    let fontSize: Int
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image("icon-back")
                    .resizable()
                    .frame(width: 16, height: 15)
                    .frame(width: 40, height: 40)
                    .foregroundColor(.black)
                    .clipShape(Circle())
                    .background(Circle().fill(Color.white).shadow(color: .black.opacity(0.1), radius: 3))
                Text(text)
                    .font(textColor, font, CGFloat(fontSize))
            }
        }
    }
}
