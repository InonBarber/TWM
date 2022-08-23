//
//  UIViewController+Extensions.swift
//  TWM
//
//  Created by Inon Barber on 22/08/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func switchRootViewController(rootViewController: UIViewController) {
        
        guard let window = self.view.window else { return }
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve) {
            let oldStat = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            window.rootViewController = rootViewController
            UIView.setAnimationsEnabled(oldStat)
        }
    }
    
}
