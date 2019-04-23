//
//  ModelController.swift
//  RecoveryConnections
//
//  Created by Douglas Patterson on 2/20/19.
//  Copyright © 2019 Douglas Patterson. All rights reserved.
//

import CoreData
import UIKit

class ModelController {
    
    //==================================================
    // MARK: - Properties
    //==================================================
    
    static let sharedController = ModelController()
    var commitmentArray: [Commitment] {
        let request: NSFetchRequest<Commitment> = Commitment.fetchRequest()
        do {
            return try Stack.context.fetch(request)
        } catch {
            return []
        }
    }
    
    var startDateArray: [StartDate] {
        let request: NSFetchRequest<StartDate> = StartDate.fetchRequest()
        do {
            return try Stack.context.fetch(request)
        } catch {
            return []
        }
    }
    
    //==================================================
    // MARK: - Functions
    //==================================================
    
    func createCommitment(reason: String?, commitmentMade: Bool, commitmentKept: Bool?, difficulty: Int16?, currentDate: Date, notes: String?, motivationalImage: Data?) {
        guard let reason = reason else { return }
        let _ = Commitment(reason: reason, commitmentMade: commitmentMade, commitmentKept: commitmentKept, diffictuly: difficulty, currentDate: currentDate, notes: notes, motivationalImage: motivationalImage)
        saveToPersistentStorage()
    }
    
    func deleteCommitment(commitment: Commitment) {
        Stack.context.delete(commitment)
        saveToPersistentStorage()
    }
    
    func deleteSobrietyDate(startDate: StartDate) {
        Stack.context.delete(startDate)
        saveToPersistentStorage()
    }
    
    func newSobrietyDate(sobrietyDate: Date) {
        let _ = StartDate(sobrietyDate: sobrietyDate)
        saveToPersistentStorage()
    }
    
    func saveToPersistentStorage() {
        do {
            try Stack.context.save()
        } catch {
            print("Error. Could not Commitment to CoreData.")
        }
    }
    
}
