//
//  InfoVViewController.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 02/06/24.
//

import UIKit

class InfoViewController: UIViewController {
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Message", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemTeal
        view.addSubview(actionButton)
        
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
    
    @objc func showAlert() {
        let alertController = UIAlertController(title: "Alert title", message: "Alert message", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Left action", style: .default) { _ in print("Action 1")
        }
        
        let action2 = UIAlertAction(title: "Right action", style: .default) { _ in print("Action 2")
        }
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        
        present(alertController, animated: true, completion: nil)
    }
}
