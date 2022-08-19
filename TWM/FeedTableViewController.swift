//
//  StudentsTableViewController.swift
//  StudentApp
//
//  Created by Kely Sotsky on 06/04/2022.
//

import UIKit

class FeedTableViewController: UITableViewController {

    var data = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data.append(Post(name: "Kely", id: "444", avatarUrl: ""))
        data.append(Post(name: "Kely1", id: "333", avatarUrl: ""))
        data.append(Post(name: "Kely2", id: "222", avatarUrl: ""))
        data.append(Post(name: "Kely3", id: "111", avatarUrl: ""))

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        let st = data[indexPath.row]
        cell.nameLabel.text = st.name
        cell.id = st.id

        return cell
    }
    
    var selectedRow = 0
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("Selcted row at \(indexPath.row)")
        selectedRow = indexPath.row
        performSegue(withIdentifier: "openPostDetails", sender: self)
        
        
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    
    // MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "openPostDetails"){
            let dvc = segue.destination as! PostDetailsViewController
            let st = data[selectedRow]
            dvc.post = st
        }
    }
    

}
