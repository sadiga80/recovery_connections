//
//  SobrietyDateViewController.swift
//  RecoveryConnections
//
//  Created by Douglas Patterson on 2/25/19.
//  Copyright © 2019 Douglas Patterson. All rights reserved.
//

import UIKit
import CoreData

class SobrietyDateViewController: UIViewController {
    
    //==================================================
    // MARK: - Properties
    //==================================================
    
    var currentDate = Date()
    var startDate: StartDate?
    //Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var submitButton: RoundButton!
    @IBOutlet weak var cancelButton: RoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.maximumDate = currentDate
    }
    
    //==================================================
    // MARK: - Functions
    //==================================================
    
    func getStartDate() {
        let startDateArray = ModelController.sharedController.startDateArray
        if startDateArray == [] {
            ModelController.sharedController.newSobrietyDate(sobrietyDate: datePicker.date)
        } else {
            safelyRemoveAllItemsFromStartDateArray()
            ModelController.sharedController.newSobrietyDate(sobrietyDate: datePicker.date)
        }
    }
    
    func safelyRemoveAllItemsFromStartDateArray() {
        for startDate in ModelController.sharedController.startDateArray {
            ModelController.sharedController.deleteSobrietyDate(startDate: startDate)
        }
    }
    
    //==================================================
    // MARK: - Actions
    //==================================================
    
    @IBAction func datePickerChanged(_ sender: Any) {
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
       getStartDate()
//       print(SobrietyCounterController.sharedController.startDateArray)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
    }
}
