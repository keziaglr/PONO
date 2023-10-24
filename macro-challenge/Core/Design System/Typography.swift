//
//  Typography.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 23/10/23.
//

import SwiftUI

struct TextLabel: ViewModifier {
    let font: UIFont
    let lineHeight: CGFloat
    
    init(font: UIFont, lineHeight: CGFloat) {
        self.font = font
        self.lineHeight = lineHeight
    }
    
    init(size: CGFloat, weight: UIFont.Weight, lineHeight: CGFloat) {
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.lineHeight = lineHeight
    }
    
    init(style: Style) {
        self.font = style.font
        self.lineHeight = style.lineHeight
    }
    
    func body(content: Content) -> some View {
        content
            .font(Font(font))
            .lineSpacing(lineHeight - font.lineHeight)
    }
    
    enum Style {
        case heading1
        case heading2
        case heading3
        case heading4
        case heading5
        case heading6
        case largeTextBold
        case largeText
        case mediumBold
        case medium
        case normalBold
        case normal
        case smallBold
        case small
        
        var font: UIFont {
            switch self {
            case .heading1:
                return UIFont(name: "Quicksand-Bold", size: 56) ?? .systemFont(ofSize: 56, weight: .bold)
            case .heading2:
                return UIFont(name: "Quicksand-Bold", size: 48) ?? .systemFont(ofSize: 48, weight: .bold)
            case .heading3:
                return UIFont(name: "Quicksand-Bold", size: 40) ?? .systemFont(ofSize: 40, weight: .bold)
            case .heading4:
                return UIFont(name: "Quicksand-Bold", size: 32) ?? .systemFont(ofSize: 32, weight: .bold)
            case .heading5:
                return UIFont(name: "Quicksand-Bold", size: 24) ?? .systemFont(ofSize: 24, weight: .bold)
            case .heading6:
                return UIFont(name: "Quicksand-Bold", size: 20) ?? .systemFont(ofSize: 20, weight: .bold)
            case .largeTextBold:
                return UIFont(name: "Quicksand-Bold", size: 20) ?? .systemFont(ofSize: 20, weight: .bold)
            case .largeText:
                return UIFont(name: "Quicksand-Regular", size: 20) ?? .systemFont(ofSize: 20, weight: .regular)
            case .mediumBold:
                return UIFont(name: "Quicksand-Bold", size: 18) ?? .systemFont(ofSize: 18, weight: .bold)
            case .medium:
                return UIFont(name: "Quicksand-Regular", size: 18) ?? .systemFont(ofSize: 18, weight: .regular)
            case .normalBold:
                return UIFont(name: "Quicksand-Bold", size: 16) ?? .systemFont(ofSize: 16, weight: .bold)
            case .normal:
                return UIFont(name: "Quicksand-Regular", size: 16) ?? .systemFont(ofSize: 16, weight: .regular)
            case .smallBold:
                return UIFont(name: "Quicksand-Bold", size: 14) ?? .systemFont(ofSize: 14, weight: .bold)
            case .small:
                return UIFont(name: "Quicksand-Regular", size: 14) ?? .systemFont(ofSize: 14, weight: .regular)
            }
        }
        
        var lineHeight: CGFloat {
            switch self {
            case .heading1:
                return 61.6
            case .heading2:
                return 52.8
            case .heading3:
                return 44
            case .heading4:
                return 35.2
            case .heading5:
                return 26.4
            case .heading6:
                return 22
            case .largeTextBold:
                return 28
            case .largeText:
                return 28
            case .mediumBold:
                return 25.2
            case .medium:
                return 25.2
            case .normalBold:
                return 22.4
            case .normal:
                return 22.4
            case .smallBold:
                return 19.6
            case .small:
                return 19.6
            }
        }
    }
    
    
}
