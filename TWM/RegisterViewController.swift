//
//  RegisterViewController.swift
//  TWM
//
//  Created by Naum Rabich on 21/08/2022.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var takeMeInBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func TakeMeIn(_ sender: Any) {
        guard let password = passwordTextField.text, let email = emailTextField.text else { return }
                
        let user = User()
        
        user.email = email
        user.firstName = firstNameTextField.text
        user.lastName = lastNameTextField.text
        user.phone = phoneTextField.text
        
        let validPassword = self.checkPassword(password: self.passwordTextField.text!)
        let validEmail = self.validEmail(email: emailTextField.text!)
        if validPassword == false {
            myalert(title: "Faild to register", msg: "Password should be at least 5 characters")
        }
        else if validEmail == false {
            myalert(title: "Faild to register", msg: "Email not valid")
        }
        else{
            Model.instance.checkIfUserExist(email: user.email) { [weak self] success in
                if( success == true){
                    self?.myalert(title: "Faild to register", msg: "Email is already in use")
                }
                else{
                    Model.instance.createUser(email: user.email, password: password) {success in
                        if success == true{
                            Model.instance.addUser(user: user) {
                                self?.navigateToFeeds()
                            }
                        }
                    }
                }
            }
        }
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
    
    func myalert(title: String, msg: String){
        let alertC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertC.addAction(okBtn)
        self.dismiss(animated: false) { () -> Void in
            self.present(alertC, animated: true, completion: nil)
        }
        
    }
}
