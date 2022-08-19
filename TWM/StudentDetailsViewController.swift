//
//  StudentDetailsViewController.swift
//  StudentApp
//
//  Created by Kely Sotsky on 06/04/2022.
//

import UIKit

class StudentDetailsViewController: UIViewController {

    var student:Student?{
        didSet{
            if(idLabel != nil){
                idLabel.text = student?.id
                nameLabel.text = student?.name
            }
        }
    }
    
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let student = student {
            idLabel.text = student.id
            nameLabel.text = student.name
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
