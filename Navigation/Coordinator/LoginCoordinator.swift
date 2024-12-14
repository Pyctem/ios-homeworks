//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 04/11/24.
//

import Foundation
import UIKit


class LoginCoordinator: BaseCoordinator {
    var childrenCoordinator: [BaseCoordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let profileViewController = LogInViewController(userService: CurrentUserService(user: User(username: "User", fullName: "FullUsername", avatar: UIImage(named: "cat")!, status: "UserStatus")))
        let loginFactory = MyLoginFactory();
        
        profileViewController.loginDelegate = loginFactory.makeLoginInspector()
        profileViewController.coordinator = self
        
        navigationController.pushViewController(profileViewController, animated: false)
        navigationController.isNavigationBarHidden = true
    }
    
    func showUser(user: User) {
        let porfileViewModel = ProfileViewModel(user: user)
        let profileViewController = ProfileViewController(userModelView: porfileViewModel)
        navigationController.pushViewController(profileViewController, animated: false)
    }
}
