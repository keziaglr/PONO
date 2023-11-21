//
//  ButtonView.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 27/10/23.
//

import SwiftUI

struct PonoButtonStyle: ButtonStyle {
    @State private var variant: Variant
    @State private var pressed = false
    
    init(variant: Variant, action: @escaping () -> Void = {}) {
        self.variant = variant
        self.pressed = pressed
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.system(size: variant.labelSize, weight: .bold))
            .foregroundStyle(variant.labelColor)
            .frame(maxWidth: variant.width, maxHeight: variant.height)
            .animation(.easeInOut(duration: 0.5), value: configuration.isPressed)
            .background() {
                RoundedRectangle(cornerRadius: 20)
                    .fill(variant.backgroundColor)
                    .shadow(color: configuration.isPressed ? pressBtn() : variant.shadow, radius: 0, x: 0, y: 8)
            }
            .offset(y: configuration.isPressed ? 8 : 0)
    }
    
    func pressBtn() -> Color {
        ContentManager.shared.playAudio("button-click", type: "wav")
        return .clear
    }
    
    enum Variant {
        case primary
        case secondary
        case tertiary
        case quaternary
        
        var backgroundColor: Color {
            switch self {
            case .primary:
                return Color.Yellow2
            case .secondary:
                return Color.White1
            case .tertiary:
                return Color.White1
            case .quaternary:
                return .clear
            }
        }
        
        var shadow: Color {
            switch self {
            case .primary:
                return Color.Yellow1
            case .secondary:
                return Color.Grey3
            case .tertiary:
                return Color.Grey3
            case .quaternary:
                return .clear
            }
        }
        
        var width: CGFloat {
            switch self {
            case .primary:
                return .infinity
            case .secondary:
                return 200
            case .tertiary:
                return 108
            case .quaternary:
                return .infinity
            }
        }
        
        var height: CGFloat {
            switch self {
            case .primary:
                return 80
            case .secondary:
                return 200
            case .tertiary:
                return 80
            case .quaternary:
                return .infinity
            }
        }
        
        var labelColor: Color {
            switch self {
            case .primary:
                return Color.White1
            case .secondary:
                return Color.Yellow2
            case .tertiary:
                return Color.Yellow2
            case .quaternary:
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
                return 45
            case .quaternary:
                return .infinity
            }
        }
    }
}
