//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 17/07/24.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    private let profileHeaderView = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: nil)
        view.backgroundColor = .lightGray
    }
    
    override func viewWillLayoutSubviews() {
        view.addSubview(profileHeaderView)
        profileHeaderView.frame = self.view.frame
    }
}
