//
//  Commitment.swift
//  RecoveryConnections
//
//  Created by Douglas Patterson on 2/19/19.
//  Copyright © 2019 Douglas Patterson. All rights reserved.
//

import Foundation
import CoreData

extension Commitment {
    
    convenience init?(reason: String, commitmentMade: Bool, commitmentKept: Bool?, diffictuly: Int16?, currentDate: Date, notes: String?, motivationalImage: Data?, context: NSManagedObjectContext = Stack.context) {
        self.init(context: context)
        self.reason = reason
        self.notes = notes
        self.commitmentMade = commitmentMade
        self.commitmentKept = false
        self.difficulty = 0
        self.currentDate = currentDate
        self.motivationalImage = motivationalImage
    }
}

