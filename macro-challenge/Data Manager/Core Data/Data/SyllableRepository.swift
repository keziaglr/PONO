//
//  SyllableLocalData.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 16/11/23.
//

import Foundation
import CoreData

protocol SyllableRepository {
    func getTotalSyllable(success: @escaping (Int) -> Void, error: @escaping (String) -> Void)
    func getSyllableList(success: @escaping ([SyllableEntity]) -> Void, error: @escaping (String) -> Void)
}
