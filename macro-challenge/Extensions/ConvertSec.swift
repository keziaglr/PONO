//
//  ConvertSec.swift
//  macro-challenge
//
//  Created by Rio Johanes Sumolang on 23/10/23.
//

import Foundation

extension VoiceViewModel {
    func covertSec(seconds : Int) -> String{

        let (_,m,s) = (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        let sec : String = s < 10 ? "0\(s)" : "\(s)"
        return "\(m):\(sec)"
    }
}
