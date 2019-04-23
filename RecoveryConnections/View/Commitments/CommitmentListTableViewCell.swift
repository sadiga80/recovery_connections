//
//  CommitmentListTableViewCell.swift
//  RecoveryConnections
//
//  Created by Douglas Patterson on 2/26/19.
//  Copyright © 2019 Douglas Patterson. All rights reserved.
//

import UIKit
import CoreData

class CommitmentListTableViewCell: UITableViewCell {
    
    //==================================================
    // MARK: - Properties
    //==================================================
    
    var commitment: Commitment?
    var todaysDate = Date()
    var dateFormatter = DateFormatter()
    
    //Outlets
    @IBOutlet weak var completionImageView: UIImageView!
    @IBOutlet weak var difficultyImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var notesImageView: UIImageView!
    
    //==================================================
    // MARK: - View Lifecycle
    //==================================================
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //==================================================
    // MARK: - Functions
    //==================================================
    
    func checkForCompletion() -> UIImage? {
        guard let commitment = commitment else { return nil }
        if commitment.commitmentMade == true && commitment.commitmentKept == false {
            guard let starImage = UIImage(named: "star") else { return nil }
            return starImage
        } else if commitment.commitmentMade == true && commitment.commitmentKept == true {
            guard let filledStarImage = UIImage(named: "goldStar") else { return nil }
            return filledStarImage
        } else {
            return nil
        }
    }

    func checkForDifficulty() -> UIImage? {
        guard let commitment = commitment else { return nil }
        if commitment.difficulty == 1 {
            return UIImage(named: "difficultyOne")
        } else if commitment.difficulty == 2 {
            return UIImage(named: "difficultyTwo")
        } else if commitment.difficulty == 3 {
            return UIImage(named: "difficultyThree")
        } else if commitment.difficulty == 4 {
            return UIImage(named: "difficultyFour")
        } else if commitment.difficulty == 5 {
            return UIImage(named: "difficultyFive")
        } else {
            return nil
        }
    }
    
    func checkForNotes() -> UIImage? {
        guard let commitment = commitment else { return nil }
        if let _ = commitment.notes {
            return UIImage(named: "journal")
        } else { return nil }
    }
    
    func formatCurrentDate() -> String? {
        guard let commitmentDate = commitment?.currentDate else { return nil }
        dateFormatter.dateFormat = "EEEE, MMMM d"
        return dateFormatter.string(from: commitmentDate)
    }
    
    func update(with commitment: Commitment) {
        self.commitment = commitment
        completionImageView.image = checkForCompletion()
        difficultyImageView.image = checkForDifficulty()
        dateLabel.text = formatCurrentDate() ?? ""
        notesImageView.image = checkForNotes()
    }
}
