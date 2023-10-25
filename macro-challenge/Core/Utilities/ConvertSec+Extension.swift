//
//  ConvertSec+Extension.swift
//  macro-challenge
//
//  Created by Rio Johanes Sumolang on 25/10/23.
//

import Foundation

extension Int {
    func convertSec() -> String{
        
        let (_,m,s) = (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
        let sec : String = s < 10 ? "0\(s)" : "\(s)"
        return "\(m):\(sec)"
    }

}
