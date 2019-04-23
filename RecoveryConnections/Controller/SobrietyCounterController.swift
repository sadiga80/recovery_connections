//
//  SobrietyCounterController.swift
//  RecoveryConnections
//
//  Created by Douglas Patterson on 2/25/19.
//  Copyright © 2019 Douglas Patterson. All rights reserved.
//

import Foundation
import CoreData

class SobrietyCounterController {
    //==================================================
    // MARK: - Properties
    //==================================================
    
    static let sharedController = SobrietyCounterController()
    let dateFormatter = DateFormatter()
    var startDate: StartDate?
    let currentDate = Date()
    var calendar = Calendar.current

    func getNumberOfDaysSober() -> Int? {
        startDate = ModelController.sharedController.startDateArray.last
        guard let sobrietyDate = startDate?.sobrietyDate else { return nil }
        let differenceInDays = Calendar.current.dateComponents([.day], from: sobrietyDate, to: currentDate).day
        print(differenceInDays as Any)
        return differenceInDays
    }
}



