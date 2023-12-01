//
//  GlowBorderReportTitle.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 22/11/23.
//

import SwiftUI

struct GlowBorderReportTitle: ViewModifier {
    var color: Color
    var lineWidth: Int
    
    func body(content: Content) -> some View {
        applyShadow(content: AnyView(content), lineWidth: lineWidth)
    }
    
    func applyShadow(content: AnyView, lineWidth: Int) -> AnyView {
        if lineWidth == 0 {
            return content
        } else {
            return applyShadow(content: AnyView(content.shadow(color: .white, radius: 0.5)), lineWidth: lineWidth - 1)
        }
    }
    
}

extension View {
    func glowBorder(color: Color, lineWidth: Int) -> some View {
        self.modifier(GlowBorderReportTitle(color: color, lineWidth: lineWidth))
    }
}


