//
//  ViewController.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 02/06/24.
//

import UIKit

class FeedViewController: UIViewController {
    
    private lazy var actionButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(actionButton)
        
        title = "Feed"
        tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "book"), selectedImage: nil)
        
        view.backgroundColor = .systemBackground
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 20.0
            ),
            actionButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -20.0
            ),
            actionButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 44.0)
        ])
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        let postViewController = PostViewController()
        
        postViewController.post = Post(title: "Post title")
        
        navigationController?.pushViewController(postViewController, animated: true)
    }
}
