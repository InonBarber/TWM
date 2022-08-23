//
//  UIViewController+Extensions.swift
//  TWM
//
//  Created by Inon Barber on 22/08/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    private func switchRootViewController(rootViewController: UIViewController) {
        
        guard let window = self.view.window else { return }
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve) {
            let oldStat = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            window.rootViewController = rootViewController
            UIView.setAnimationsEnabled(oldStat)
        }
    }
    
    func navigateToOnboarding() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "onboardingNavigation")
        switchRootViewController(rootViewController: vc)
    }
    
    func navigateToFeeds() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "feeds") as! FeedTableViewController
        vc.updateData(feedType: .all)
        let nav = UINavigationController(rootViewController: vc)
        switchRootViewController(rootViewController: nav)
    }
    
}
