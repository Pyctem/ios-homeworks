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
        view.addSubview(profileHeaderView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Привязываем к Safe Area сверху
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            // Отступы по бокам
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // Устанавливаем высоту 220
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
}
