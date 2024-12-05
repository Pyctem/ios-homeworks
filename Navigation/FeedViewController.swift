//
//  ViewController.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 02/06/24.
//

import UIKit

class FeedViewController: UIViewController {
    var coordinator: FeedCoordinator?
    
    private var feed = FeedModel()
    
    private lazy var firstButton: UIButton = {
        CustomButton(title: "Open Post 1", titleColor: .systemBlue, action: firstButtonPressed(_:))
    }()
    
    private lazy var secondButton: UIButton = {
        CustomButton(title: "Open Post 2", titleColor: .systemBlue, action: secondButtonPressed(_:))
    }()
    
    private lazy var checkGuessButton: UIButton = {
        CustomButton(title: "Check Guess", titleColor: .systemBlue, action: checkGuess)
    }()
    
    private lazy var guessTextField = {
        let textField = UITextField()
        
        textField.placeholder = "Enter guess"
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
        
        title = "Feed"
        tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "book"), selectedImage: nil)
        view.backgroundColor = .systemBackground
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(secondButton)
        stackView.addArrangedSubview(guessTextField)
        stackView.addArrangedSubview(checkGuessButton)
        stackView.addArrangedSubview(label)
    }
    
    private func setupConstraints() {
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
        let post = Post(title: "Post 1")
        
        coordinator?.showPost(post: post)
    }
    
    @objc private func secondButtonPressed(_ sender: UIButton) {
        let post = Post(title: "Post 2")
        
        coordinator?.showPost(post: post)
    }
    
    @objc private func checkGuess(_ sender: UIButton) {
        if let guessText = guessTextField.text {
            if (feed.check(guessText)) {
                label.textColor = .green
                label.text = "The guess is match"
            } else {
                label.textColor = .red
                label.text = "The guess not's match"
            }
        } else {
            label.text = "Is Empty"
            label.textColor = .red
        }
    }
}
