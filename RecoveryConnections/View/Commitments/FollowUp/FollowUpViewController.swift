//
//  FollowUpViewController.swift
//  RecoveryConnections
//
//  Created by Douglas Patterson on 3/6/19.
//  Copyright © 2019 Douglas Patterson. All rights reserved.
//

import UIKit

class FollowUpViewController: UIViewController {
    
    //==================================================
    // MARK: - Properties
    //==================================================
    
    var commitment: Commitment?
    var difficulty: Int16?
    let dateFormatter = DateFormatter()
    let alertControler = UIAlertController()

    //Outlets
    
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var motivationalImage: UIImageView!
    @IBOutlet weak var commitmentKeptSwitch: UISwitch!
    @IBOutlet weak var commitmentKeptLabel: UILabel!
    @IBOutlet weak var difficultyOneButton: UIButton!
    @IBOutlet weak var difficultyTwoButton: UIButton!
    @IBOutlet weak var difficultyThreeButton: UIButton!
    @IBOutlet weak var difficultyFourButton: UIButton!
    @IBOutlet weak var difficultyFiveButton: UIButton!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    
    //==================================================
    // MARK: - View LifeCycle
    //==================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.navigationItem.title = formatCurrentDate()
        difficultyLabel.text = ""
        motivationalImage.image = setImage()
        reasonLabel.text = setReasonLabelText()
        setDifficulty()
        updateDifficultyButtons()
        notesTextView.text = commitment?.notes
    }
    
    //==================================================
    // MARK: - Functions
    //==================================================
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    //Commitment Difficulty
    
    func setDifficulty() {
        guard let commitmentDifficulty = commitment?.difficulty else { return }
        difficulty = commitmentDifficulty
    }
    
    func updateDifficultyButtons() {
        if difficulty == 1 {
            difficultyOneButton.alpha = 1.0
            difficultyTwoButton.alpha = 0.2
            difficultyThreeButton.alpha = 0.2
            difficultyFourButton.alpha = 0.2
            difficultyFiveButton.alpha = 0.2
        } else if difficulty == 2 {
            difficultyOneButton.alpha = 0.2
            difficultyTwoButton.alpha = 1.0
            difficultyThreeButton.alpha = 0.2
            difficultyFourButton.alpha = 0.2
            difficultyFiveButton.alpha = 0.2
        } else if difficulty == 3 {
            difficultyOneButton.alpha = 0.2
            difficultyTwoButton.alpha = 0.2
            difficultyThreeButton.alpha = 1.0
            difficultyFourButton.alpha = 0.2
            difficultyFiveButton.alpha = 0.2
        } else if difficulty == 4 {
            difficultyOneButton.alpha = 0.2
            difficultyTwoButton.alpha = 0.2
            difficultyThreeButton.alpha = 0.2
            difficultyFourButton.alpha = 1.0
            difficultyFiveButton.alpha = 0.2
        } else if difficulty == 5 {
            difficultyOneButton.alpha = 0.2
            difficultyTwoButton.alpha = 0.2
            difficultyThreeButton.alpha = 0.2
            difficultyFourButton.alpha = 0.2
            difficultyFiveButton.alpha = 1.0
        }
    }
    
    func checkIfCommitmentWasKept() -> Bool {
        if commitmentKeptSwitch.isOn == true {
            return true
        } else {
            return false
        }
    }

    func formatCurrentDate() -> String? {
        guard let commitmentDate = commitment?.currentDate else { return nil }
        dateFormatter.dateFormat = "EEEE, MMMM d"
        return dateFormatter.string(from: commitmentDate)
    }
    
    func setReasonLabelText() -> String? {
        guard let reason = commitment?.reason else {
            return "Today I have commited to stay sober!" }
        if reason == "" {
             return "Today I have commited to stay sober!"
        } else {
            return "I have commited to stay sober because \(reason)"
        }
    }
    
    func setImage() -> UIImage? {
        guard let unwrappedImageDate = commitment?.motivationalImage,
            let image = UIImage(data: unwrappedImageDate) else {
                return UIImage(named: "defaultPhoto") }
        return image
    }
    
    func checkForNotes() -> String? {
        if notesTextView.text != "Notes" && notesTextView.text != "" {
            return notesTextView.text
        } else {
            return nil
        }
    }
    
    //==================================================
    // MARK: - Actions
    //==================================================
    
    @IBAction func difficultyOneButtonTapped(_ sender: Any) {
        difficultyLabel.text = "Great!"
        difficulty = 1
        updateDifficultyButtons()
    }
    
    @IBAction func difficultyTwoButtonTapped(_ sender: Any) {
        difficultyLabel.text = "Good!"
        difficulty = 2
        updateDifficultyButtons()
    }
    
    @IBAction func difficultyThreeButtonTapped(_ sender: Any) {
        difficultyLabel.text = "Ok"
        difficulty = 3
        updateDifficultyButtons()
    }
    
    @IBAction func difficultyFourButtonTapped(_ sender: Any) {
        difficultyLabel.text = "That was tough."
        difficulty = 4
        updateDifficultyButtons()
    }
    
    @IBAction func difficultyFiveButtonTapped(_ sender: Any) {
        difficultyLabel.text = "Near impossible.."
        difficulty = 5
        updateDifficultyButtons()
    }
    
    @IBAction func commitmentKeptSwitchFlipped(_ sender: Any) {
        if commitmentKeptSwitch.isOn == true {
            commitmentKeptLabel.text = "Yes"
        } else if commitmentKeptSwitch.isOn == false {
            commitmentKeptLabel.text = "No"
        }
    }
        
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let commitment = commitment,
        let difficulty = difficulty else { return }
        commitment.difficulty = difficulty
        commitment.notes = checkForNotes()
        commitment.commitmentKept = checkIfCommitmentWasKept()
        ModelController.sharedController.saveToPersistentStorage()
        self.navigationController?.popViewController(animated: true)
    }
}
