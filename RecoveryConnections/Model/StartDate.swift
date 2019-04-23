//
//  StartDate.Swift
//  RecoveryConnections
//
//  Created by Douglas Patterson on 2/14/19.
//  Copyright © 2019 Douglas Patterson. All rights reserved.
//

import Foundation
import CoreData

extension StartDate {
    convenience init?(sobrietyDate: Date, context: NSManagedObjectContext = Stack.context) {
        self.init(context: context)
        self.sobrietyDate = sobrietyDate
    }
}

