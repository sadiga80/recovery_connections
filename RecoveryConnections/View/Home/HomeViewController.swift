//
//  HomeViewController.swift
//  RecoveryConnections
//
//  Created by Douglas Patterson on 2/15/19.
//  Copyright © 2019 Douglas Patterson. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    //==================================================
    // MARK: - Properties
    //==================================================
    
    let backGroundImageView = UIImageView()
    let dailyQuote: Quote? = {
        QuoteController.sharedController.getDailyQuote()
    }()
    
    //Outlets:
    @IBOutlet weak var todayMarksLabel: UILabel!
    @IBOutlet weak var sobrietyCounterButton: RoundButton!
    @IBOutlet weak var daysOfSobrietyLabel: UILabel!
    @IBOutlet weak var dailyQuoteLabel: UILabel!
    
    //==================================================
    // MARK: - View Lifecycle
    //==================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateDailyQuote()
        getBackGroundImage()
        sobrietyCounterButton.titleLabel?.adjustsFontSizeToFitWidth = true
        sobrietyCounterButton.titleLabel?.insetsLayoutMarginsFromSafeArea = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
       setSobrietyCounter()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.backGroundImageView.frame = self.view.bounds
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //==================================================
    // MARK: - Functions
    //==================================================
    
    func getBackGroundImage() {
        let image = UIImage(named: "riverImage3")
        self.backGroundImageView.contentMode = .scaleAspectFill
        self.backGroundImageView.image = image
        self.view.addSubview(backGroundImageView)
        view.sendSubviewToBack(backGroundImageView)
    }
    
    func setSobrietyCounter() {
        if ModelController.sharedController.startDateArray.isEmpty == true {
            todayMarksLabel.text = "Use this counter to measure your success!"
            sobrietyCounterButton.setTitle("", for: .normal)
            daysOfSobrietyLabel.text = "Tap the box to get started."
            
        } else {
           guard let daysSober = SobrietyCounterController.sharedController.getNumberOfDaysSober() else { return }
            todayMarksLabel.text = "Today marks day"
            sobrietyCounterButton.setTitle("\(daysSober)", for: .normal)
            daysOfSobrietyLabel.text = "of sobriety!"
        }
    }
    
    func populateDailyQuote() {
        if let quote = dailyQuote {
            dailyQuoteLabel.text = "\(quote.quoteText)"
        }
    }
}
