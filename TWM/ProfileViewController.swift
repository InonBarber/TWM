//
//  ProfileViewController.swift
//  TWM
//
//  Created by Naum Rabich on 21/08/2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var logoutBtn: UIBarButtonItem!
    @IBOutlet weak var addPostBtn: UIButton!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!

    var data = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserDetails()
    }
    
    func getUserDetails(){
        Model.instance.getUserDetails { [weak self] result in
            switch result {
            case .success(let user):
                self?.updateUserInfo(user: user)
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateUserInfo(user: User) {
        emailLabel.text = user.email
        lastNameLabel.text = user.lastName
        firstNameLabel.text = user.firstName
        phoneLabel.text = user.phone
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userFeeds" {
            if let nextViewController = segue.destination as? FeedTableViewController {
                nextViewController.updateData(feedType: .myFeeds)
            }
        }
    }
    
    @IBAction func logout(_ sender: Any) {
        Model.instance.signOut { [weak self] success in
            if success {
                self?.navigateToOnboarding()
            }
        }
    }
    
    @IBAction func moveToaddPost(_ sender: Any) {
        return
    }
}
