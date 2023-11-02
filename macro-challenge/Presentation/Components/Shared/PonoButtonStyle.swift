//
//  ButtonView.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 27/10/23.
//

import SwiftUI

struct PonoButtonStyle: ButtonStyle {
    let height : CGFloat = 80
    let variant: Variant
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: variant.size)
            .background() {
                RoundedRectangle(cornerRadius: 20)
                    .fill(variant.backgroundColor)
                    .shadow(color: variant.shadow, radius: 0, x: 0, y: 8)
            }
    }
    
    enum Variant {
        case primary
        case secondary
        case tertiary
        
        var backgroundColor: Color {
            switch self {
            case .primary:
                return Color.Blue1
            case .secondary:
                return Color.White1
            case .tertiary:
                return Color.Blue1
            }
        }
        
        var shadow: Color {
            switch self {
            case .primary:
                return Color.Blue5
            case .secondary:
                return Color.Grey2
            case .tertiary:
                return .clear
            }
        }
        
        var size: CGFloat {
            switch self {
            case .primary:
                return .infinity
            case .secondary:
                return 100
            case .tertiary:
                return .infinity
            }
        }
    }
}
