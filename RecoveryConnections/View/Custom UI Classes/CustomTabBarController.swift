//
//  CustomTabBarController.swift
//  RecoveryConnections
//
//  Created by Douglas Patterson on 3/15/19.
//  Copyright © 2019 Douglas Patterson. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        self.tabBar.unselectedItemTintColor = UIColor.white
    }
}

extension CustomTabBarController: UITabBarControllerDelegate  {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false
        }        
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.2, options: [.transitionCrossDissolve], completion: nil)
        }
        return true
    }
}
