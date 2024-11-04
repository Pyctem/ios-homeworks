//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 04/11/24.
//

import Foundation
import UIKit

class FeedCoordinator: BaseCoordinator {
    var childrenCoordinator: [BaseCoordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let feedViewController = FeedViewController()
        
        feedViewController.coordinator = self
        
        navigationController.pushViewController(feedViewController, animated: false)
        navigationController.isNavigationBarHidden = true
    }
    
    func showPost(post: Post) {
        let postViewController = PostViewController()
        postViewController.post = post
        
        navigationController.pushViewController(postViewController, animated: false)
    }
}
