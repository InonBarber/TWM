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
                self?.navigateToFeeds()
            } else {
                //navigate to login
                self?.navigateToOnboarding()
            }
        }
    }
}
