//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 04/11/24.
//

import Foundation
import UIKit

class MainCoordinator: AppCoordinator {
    var childrenCoordinator = [BaseCoordinator]()
    
    let window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let rootViewController = UITabBarController()
        let feedNavigationController = UINavigationController()
        let loginNavigationController = UINavigationController()
        
        let feedCoordinator = FeedCoordinator(navigationController: feedNavigationController)
        let loginCoordinator = LoginCoordinator(navigationController: loginNavigationController)
        
        childrenCoordinator.append(feedCoordinator)
        childrenCoordinator.append(loginCoordinator)
        
        feedCoordinator.start()
        loginCoordinator.start()
        
        rootViewController.viewControllers = [feedNavigationController, loginNavigationController]
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}
