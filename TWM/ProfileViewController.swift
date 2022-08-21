//
//  ProfileViewController.swift
//  TWM
//
//  Created by Naum Rabich on 21/08/2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    
    @IBOutlet weak var editPostBtn: UIButton!
    @IBOutlet weak var addPostBtn: UIButton!
    
    @IBAction func addPostBtn(_ sender: Any) {
    }
    
    @IBAction func editPostBtn(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
