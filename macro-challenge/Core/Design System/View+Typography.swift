//
//  View+Typography.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 23/10/23.
//

import SwiftUI

extension View {
    func textStyle(style: TextLabel.Style) -> some View {
        modifier(TextLabel(style: style))
    }
}
