//
//  InfoVViewController.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 02/06/24.
//

import Foundation
import UIKit

class InfoVViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .system)
        button.setTitle("Message", for: .normal)
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
        
        view.addSubview(button)
    }
    
    @objc func showAlert() {
        let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Action 1", style: .default) { _ in
            print("Action 1")
        }
        let action2 = UIAlertAction(title: "Action 2", style: .default) { _ in
            print("Action 2")
        }
        alertController.addAction(action1)
        alertController.addAction(action2)
        present(alertController, animated: true, completion: nil)
    }
}
