//
//  SplashViewController.swift
//  TWM
//
//  Created by Inon Barber on 22/08/2022.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var loader: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.startAnimating()        
        startup()
    }
    
    private func startup() {
        Model.instance.checkIfUserLoggedIn { [weak self] success in
            if success {
                //navigate to feeds
                self?.showFeeds()
            } else {
                //navigate to login
                self?.showLogin()
            }
        }
    }
    
    private func showFeeds() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "feeds") as! FeedTableViewController
        vc.updateData(feedType: .all)
        let nav = UINavigationController(rootViewController: vc)
        self.switchRootViewController(rootViewController: nav)
    }
    
    private func showLogin() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "onboardingNavigation")
        self.switchRootViewController(rootViewController: vc)
    }
}
