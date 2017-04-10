//
//  PotholeTableViewController.swift
//  Pothole Hunter
//
//  Created by Brijesh Patel on 2017-03-15.
//  Copyright © 2017 Brijesh Patel. All rights reserved.
//

import UIKit
import Firebase

class PotholeTableViewController: UITableViewController {
    
    var index:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PotholeData.potholes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PotholeTabelViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PotholeTableViewCell  else {
            fatalError("The dequeued cell is not an instance of PotholeTableViewCell.")
        }
        let pothole = PotholeData.potholes[indexPath.row]
        print("table cell creation")
        print(pothole)
        cell.addressLabel.text = pothole.address
        cell.dateLabel.text = "Captured On:" + pothole.capturedOn!
        cell.severityLabel.text = "Severity: \(pothole.severity!) out of 10"
        if(pothole.severity! <= 4){
            cell.colorView.backgroundColor = .yellow
            print("color yellow")
        }
        else if(pothole.severity! < 8){
            cell.colorView.backgroundColor = .blue
            print("color blue")
        }
        else{
            cell.colorView.backgroundColor = .red
            print("color red")
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        performSegue(withIdentifier: "tableToDetail", sender: PotholeData.potholes[indexPath.row])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableToDetail"{
            if let destinationVC = segue.destination as? ShowDetailViewController{
                PotholeData.getImage(i: index!)
                let pothole = PotholeData.potholes[self.index!]
                destinationVC.date = "Captured on:" + pothole.capturedOn!
                destinationVC.address = "Location:" + pothole.address!
                destinationVC.severity = "Severity:" + String(pothole.severity!)
                destinationVC.indexCalled = self.index!
            }
        }
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
