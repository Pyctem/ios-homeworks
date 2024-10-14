//
//  PostViewController.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 02/06/24.
//

import UIKit

class PostViewController: UIViewController {
    var post: Post?
    
    private lazy var barButton = {
        let button = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(showInfoViewController))
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = post?.title ?? "Post"
        self.view.backgroundColor = .systemMint        
        
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func showInfoViewController() {
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true, completion: nil)
    }
    
}
