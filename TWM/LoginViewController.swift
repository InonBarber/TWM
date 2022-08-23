//
//  LoginViewController.swift
//  TWM
//
//  Created by Naum Rabich on 21/08/2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var takeMeInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Model.instance.checkIfUserLoggedIn() { [weak self] success in
            if success {
                self?.performSegue(withIdentifier: "takeMeIn", sender: nil)
            }
        }
        
        
    }
    
    @IBAction func TakeMeIn(_ sender: Any) {
        
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            return
        }
        
        Model.instance.login(email: email, password: password){ [weak self] success in
            if success{
                self?.navigationController?.popViewController(animated: true)
            } else {
                let alertC = UIAlertController(title: "Faild to log in", message: "Email or password is incorrect", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alertC.addAction(okButton)
                self?.dismiss(animated: false){ () -> Void in
                     self?.present(alertC, animated: true, completion: nil)
                }
            }
        }
    }
    
    

}
