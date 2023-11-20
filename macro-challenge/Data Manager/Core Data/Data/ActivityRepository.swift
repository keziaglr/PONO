//
//  ActivityLocalData.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 16/11/23.
//

import Foundation

protocol ActivityRepository {
    func getList(success: @escaping ([ActivityEntity]) -> Void, error: @escaping (String) -> Void)
    func create(wordId: String, syllable1: String, syllable2: String, success: @escaping () -> Void, error: @escaping (String?) -> Void)
    func updateWord(
        activityId: String,
        isPronunciationCorrect: Bool?,
        success: @escaping () -> Void,
        error: @escaping (String) -> Void
    )
    func updateSyllable(
        activityId: String,
        syllableId: String,
        isCardCorrect: Bool?,
        isPronunciationCorrect: Bool?,
        success: @escaping () -> Void,
        error: @escaping (String) -> Void
    )
}
