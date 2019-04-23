//
//  MakeCommitmentViewController.swift
//  RecoveryConnections
//
//  Created by Douglas Patterson on 2/22/19.
//  Copyright © 2019 Douglas Patterson. All rights reserved.
//

import UIKit
import CoreData

class MakeCommitmentViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    //==================================================
    // MARK: - Properties
    //==================================================
    
    let commitmentMade = false
    var difficultyRating: Int16? = 0
    var commitmentArray = ModelController.sharedController.commitmentArray
    var commitment: Commitment? 
    
    //Outlets
    @IBOutlet weak var reasonTextField: UITextField!
    @IBOutlet weak var motivationalImage: UIImageView!
    @IBOutlet weak var commitButton: RoundButton!
    @IBOutlet weak var setImageButton: RoundButton!
    
    //==================================================
    // MARK: - View LifeCycle
    //==================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reasonTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateSetImageButtonText()
    }
    
    //==================================================
    // MARK: - Functions
    //==================================================
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func updateSetImageButtonText() {
        if motivationalImage.image != UIImage(named: "noImageSelected"){
            setImageButton.setTitle("Change Image", for: .normal)
        }
    }
    
    func checkForUploadedImage() -> UIImage? {
        if motivationalImage.image == UIImage(named: "noImageSelected") {
            return UIImage(named: "defaultPhoto")
        } else {
            guard let unwrappedMotivationImage = motivationalImage.image else { return nil }
            return unwrappedMotivationImage
        }
    }
    
    //==================================================
    // MARK: - Actions
    //==================================================
    
    @IBAction func chooseImageButtonTapped(_ sender: Any) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.motivationalImage.image = image
        }
    }
    
    @IBAction func commitButtonTapped(_ sender: Any) {
        guard let reason = reasonTextField.text,
            let unwrappedImage = checkForUploadedImage() else {
                print("could not safely unwrap either reasonTextField of motivationalImage")
                return
        }
        let motivationalImage = unwrappedImage.jpegData(compressionQuality: 0.5)
        let commitmentMade = true
        let currentDate = Date()
        if let commitment = commitment {
            commitment.currentDate = currentDate
            commitment.commitmentMade = commitmentMade
            ModelController.sharedController.saveToPersistentStorage()
        } else {
            ModelController.sharedController.createCommitment(reason: reason, commitmentMade: commitmentMade, commitmentKept: nil, difficulty: nil, currentDate: currentDate, notes: nil, motivationalImage: motivationalImage)
        }
        self.navigationController?.popViewController(animated: true)
    }    
}

// Addition Keyboard Functionality for the View Controller

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

