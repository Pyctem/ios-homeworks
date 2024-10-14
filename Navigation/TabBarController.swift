//
//  TabBarController.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 02/06/24.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedViewController = FeedViewController()
        let profileViewController = LogInViewController()
        
        let controllers = [feedViewController, profileViewController].map { viewController in
            let navController = UINavigationController(rootViewController: viewController)
            navController.isNavigationBarHidden = true
            return navController
        }
        
        viewControllers = controllers
    }    
}
