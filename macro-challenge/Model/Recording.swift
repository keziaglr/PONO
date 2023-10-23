//
//  Recording.swift
//  macro-challenge
//
//  Created by Rio Johanes Sumolang on 23/10/23.
//

import Foundation

struct Recording : Equatable {
    let fileURL : URL
    let createdAt : Date
    var isPlaying : Bool
}
