//
//  Activity.swift
//  macro-challenge
//
//  Created by Kezia Gloria on 29/10/23.
//

import Foundation

enum Activity {
    case beforeBreakWord
    case afterBreakWord
    case beforeCard1
    case beforeCard2
    case afterCard
    case wrongCard
    case correctCard
    case beforeReadSyllable1
    case beforeReadSyllable2
    case beforeReadWord
    case afterReadSyllable
    case afterReadWord
    case beforeBlendWord
    case afterBlendWord
}

enum TypeReading {
    case syllable1
    case syllable2
    case word
}

protocol ActivityViewProtocol{
    var next: () -> Void { get }
}
