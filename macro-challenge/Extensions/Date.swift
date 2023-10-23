//
//  Date.swift
//  macro-challenge
//
//  Created by Rio Johanes Sumolang on 23/10/23.
//

import Foundation

extension Date
{
    func toString(dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
