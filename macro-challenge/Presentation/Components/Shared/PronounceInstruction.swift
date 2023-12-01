//
//  PronounceInstruction.swift
//  macro-challenge
//
//  Created by Mahatmaditya FRS on 29/10/23.
//

import SwiftUI

struct PronounceInstruction: View {
    
    let labelText: String
    let isDisabled: Bool
    let onClick: () -> Void
    
    @State private var isPressed = false
    
    init(_ labelText: String, isDisabled: Bool, onClick: @escaping () -> Void, isPressed: Bool = false) {
        self.labelText = labelText
        self.isDisabled = isDisabled
        self.onClick = onClick
        self.isPressed = isPressed
    }
    
    var body: some View {
        HStack {
            Button {
                onClick()
            } label: {
                    Text(labelText)
                        .foregroundColor(Color.Grey1)
                        .font(
                            .custom(FontConst.QUICKSAND_BOLD, size: 50)
                        )
                        .padding()
            }
            .buttonStyle(PonoButtonStyle(variant: .secondary))
            .disabled(isDisabled)
        }
    }
}

struct PronounceInstruction_Previews: PreviewProvider {
    static var previews: some View {
        PronounceInstruction("ba", isDisabled: false, onClick: { })
    }
}
