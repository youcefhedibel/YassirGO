//
//  UIAplication.swift
//  GoRider
//
//  Created by Mac on 02/03/2024.
//

import Foundation
import UIKit

public extension UIApplication {
    static func openSettings() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
}
