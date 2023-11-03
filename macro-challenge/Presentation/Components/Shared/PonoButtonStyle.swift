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
    @State private var pressed = false
    
    init(variant: Variant, action: @escaping () -> Void = {}) {
        self.variant = variant
//        self.action = action
        self.pressed = pressed
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.system(size: variant.labelSize, weight: .bold))
            .foregroundStyle(variant.labelColor)
            .frame(maxWidth: variant.size)
            .animation(.easeInOut(duration: 0.5), value: configuration.isPressed)
            .padding()
            .background() {
                RoundedRectangle(cornerRadius: 20)
                    .fill(variant.backgroundColor)
                    .shadow(color: configuration.isPressed ? .clear : variant.shadow, radius: 0, x: 0, y: 8)
            }
            .offset(y: configuration.isPressed ? 8 : 0)
            
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
                return .clear
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
        
        var labelColor: Color {
            switch self {
            case .primary:
                return Color.White1
            case .secondary:
                return Color.Blue1
            case .tertiary:
                return .clear
            }
        }
        
        var labelSize: CGFloat {
            switch self {
            case .primary:
                return 50
            case .secondary:
                return 40
            case .tertiary:
                return .infinity
            }
        }
    }
}
