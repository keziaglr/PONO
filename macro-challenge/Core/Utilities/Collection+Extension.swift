//
//  Collection+Extension.swift
//  macro-challenge
//
//  Created by Muhammad Rizki Ardyan on 23/10/23.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
