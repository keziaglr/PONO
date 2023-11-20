//
//  WordLocalData.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 16/11/23.
//

import Foundation

protocol WordRepository {
    func getTotalWord(success: @escaping (Int) -> Void, error: @escaping (String) -> Void)
    
    func getWordList(success: @escaping ([WordEntity]) -> Void, error: @escaping (String) -> Void)
}
