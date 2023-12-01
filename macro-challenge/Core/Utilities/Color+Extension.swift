//
//  UIColor+Extension.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 26/10/23.
//

import SwiftUI

extension Color {
    init(hex: String) {
        var hexSanitized = hex
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }

        var red: Double = 0
        var green: Double = 0
        var blue: Double = 0
        var opacity: Double = 1.0

        let scanner = Scanner(string: hexSanitized)
        var hexNumber: UInt64 = 0

        if scanner.scanHexInt64(&hexNumber) {
            red = Double((hexNumber & 0xFF000000) >> 24) / 255.0
            green = Double((hexNumber & 0x00FF0000) >> 16) / 255.0
            blue = Double((hexNumber & 0x0000FF00) >> 8) / 255.0
            opacity = Double(hexNumber & 0x000000FF) / 255.0
        }

        self.init(red: red, green: green, blue: blue, opacity: opacity)
    }
}
