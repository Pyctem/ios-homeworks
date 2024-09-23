//
//  ViewController.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 02/06/24.
//

import UIKit

class FeedViewController: UIViewController {
    
    private lazy var firstButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Open Post 1", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(firstButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var secondButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Open Post 2", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(secondButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill  // Кнопки растягиваются по всей ширине стека
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        
        title = "Feed"
        tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "book"), selectedImage: nil)
        
        view.backgroundColor = .systemBackground
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            
            firstButton.widthAnchor.constraint(equalToConstant: 200),
            firstButton.heightAnchor.constraint(equalToConstant: 44),
            
            secondButton.widthAnchor.constraint(equalToConstant: 200),
            secondButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func firstButtonPressed(_ sender: UIButton) {
        let postViewController = PostViewController()
        postViewController.post = Post(title: "Post 1")
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    @objc private func secondButtonPressed(_ sender: UIButton) {
        let postViewController = PostViewController()
        postViewController.post = Post(title: "Post 2")
        navigationController?.pushViewController(postViewController, animated: true)
    }
}
