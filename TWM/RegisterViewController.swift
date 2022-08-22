//
//  RegisterViewController.swift
//  TWM
//
//  Created by Naum Rabich on 21/08/2022.
//

import UIKit

class RegisterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func checkPassword(password:String)->Bool{
        if(password.count < 5){
            return false

        }
        return true
    }
    
    func validEmail(email: String) -> Bool {
        let emailL = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailC = NSPredicate(format: "SELF MATCHES %@", emailL)
        return emailC.evaluate(with: email)
    }
    
  \
        
        
        
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


