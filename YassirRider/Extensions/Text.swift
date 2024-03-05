//
//  Font.swift
//  GoRider
//
//  Created by Mac on 01/03/2024.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
public extension Text {
    func font(_ color: Color, _ arbinFont: Font.YassirRubik, _ size: CGFloat) -> Text {
        switch arbinFont {
        case .regular:
            return self
                .font(.custom(Font.YassirRubik.regular.rawValue, size: size))
                .foregroundColor(color)
        case .medium:
            return self
                .font(.custom(Font.YassirRubik.medium.rawValue, size: size))
                .foregroundColor(color)
        case .semiBold:
            return self
                .font(.custom(Font.YassirRubik.semiBold.rawValue, size: size))
                .foregroundColor(color)
        case .bold:
            return self
                .font(.custom(Font.YassirRubik.bold.rawValue, size: size))
                .foregroundColor(color)
        case .extraBold:
            return self
                .font(.custom(Font.YassirRubik.extraBold.rawValue, size: size))
                .foregroundColor(color)
        }
    }
}
