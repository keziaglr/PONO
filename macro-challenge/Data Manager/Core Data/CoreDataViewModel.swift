//
//  CoreDataViewModel.swift
//  macro-challenge
//
//  Created by Ferrian Redhia Pratama on 16/11/23.
//

import Foundation
import CoreData

protocol CoreDataViewModel {
    func getActivityList()
    func addActivity()
}

protocol CoreDataViewModelDelegate: AnyObject {
    func resultActivityList(data: [ActivityEntity], errorMessage: String?)
}
