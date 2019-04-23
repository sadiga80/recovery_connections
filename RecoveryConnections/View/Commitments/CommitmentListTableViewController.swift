//
//  CommitmentListTableViewController.swift
//  RecoveryConnections
//
//  Created by Douglas Patterson on 2/22/19.
//  Copyright © 2019 Douglas Patterson. All rights reserved.
//

import UIKit
import CoreData

class CommitmentListTableViewController: UITableViewController {
    
    //==================================================
    // MARK: - View Lifecycle
    //==================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //==================================================
    // MARK: - TableView Data Source
    //==================================================

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        checkIfCommitmentHasBeenMadeToday()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelController.sharedController.commitmentArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commitmentCell", for: indexPath) as! CommitmentListTableViewCell
        let commitment = ModelController.sharedController.commitmentArray.reversed()[indexPath.row]
        cell.update(with: commitment)
        return cell
    }
    
    
    //==================================================
    // MARK: - Functions
    //==================================================

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let commitment = ModelController.sharedController.commitmentArray.reversed()[indexPath.row]
            ModelController.sharedController.deleteCommitment(commitment: commitment)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }     
    }
    
    func checkIfCommitmentHasBeenMadeToday() {
        let commitmentArray = ModelController.sharedController.commitmentArray
        let latestCommitment = commitmentArray.last
        if latestCommitment?.currentDate == Date() {
            self.navigationController!.navigationBar.isUserInteractionEnabled = false
            self.navigationController!.view.isUserInteractionEnabled = false
    
        }
    }

    //==================================================
    // MARK: - Navigation
    //==================================================
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "followUpSegue" {
            //get detail view controller, selected row
            guard let followUpViewController = segue.destination as? FollowUpViewController,
                let selectedRow = tableView.indexPathForSelectedRow?.row else {
                    print("kicked from prepare for segue")
                    return }
            
            //we have the data
            let commitment = ModelController.sharedController.commitmentArray.reversed()[selectedRow]
            
            //give it to the destination
            followUpViewController.commitment = commitment
            
        }
    }
}
