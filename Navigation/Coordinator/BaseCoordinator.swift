//
//  BaseCoordinator.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 04/11/24.
//

import Foundation
import UIKit

protocol AppCoordinator {
    var window: UIWindow? { get }
    var childrenCoordinator: [BaseCoordinator] { get }
    func start()
}

protocol BaseCoordinator {
    var childrenCoordinator: [BaseCoordinator] { get }
    var navigationController: UINavigationController { get }
    func start()
}
