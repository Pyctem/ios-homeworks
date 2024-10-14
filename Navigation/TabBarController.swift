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
        let profileViewController = ProfileViewController()
        
        let constollers = [feedViewController, profileViewController]
        
        viewControllers = constollers.map({ UINavigationController(rootViewController: $0) })
    }
    
}
