//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 17/07/24.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    fileprivate let data = PostItem.make()
    
    private let profileHeaderView = ProfileHeaderView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .plain
        )
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private lazy var overlayView: UIView = {
        let overlay = UIView()
        
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        overlay.alpha = 0
        
        overlay.translatesAutoresizingMaskIntoConstraints = false
        
        return overlay
    }()
    
    private lazy var closeView: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.alpha = 0
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: nil)
        view.backgroundColor = .lightGray
        
        setupViews()
        setupConstraints()
        tuneTableView()
        
        closeView.addTarget(self, action: #selector(handleCloseButtonTap), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleAvatarTap))
        
        profileHeaderView.getAvatarImageView().addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.indexPathsForSelectedRows?.forEach{ indexPath in
            tableView.deselectRow(
                at: indexPath,
                animated: animated
            )
        }
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(overlayView)
        view.addSubview(closeView)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            closeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
        ])
    }
    
    private func tuneTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.separatorStyle = .none

        tableView.setAndLayout(headerView: profileHeaderView)
        tableView.tableFooterView = UIView()
        
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: "custom"
        )
        
        tableView.register(
            PhotoTableViewCell.self,
            forCellReuseIdentifier: PhotoTableViewCell.identifier
        )
                
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc private func handleAvatarTap() {
        let avatarImageView = profileHeaderView.getAvatarImageView()
        let originalFrame = avatarImageView.superview?.convert(avatarImageView.frame, to: nil) ?? .zero
        
        let enlargedFrame = CGRect(
            x: 0,
            y: view.center.y - (originalFrame.height * (view.frame.width / originalFrame.width)) / 2,
            width: view.frame.width,
            height: originalFrame.height * (view.frame.width / originalFrame.width)
        )
        
        let copyImageView = UIImageView(image: avatarImageView.image)
        copyImageView.contentMode = .scaleAspectFill
        copyImageView.clipsToBounds = true
        copyImageView.frame = originalFrame
        view.addSubview(copyImageView)
        
        UIView.animate(withDuration: 0.5, animations: {
            copyImageView.frame = enlargedFrame
            self.overlayView.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.closeView.alpha = 1
            }
        })
    }
    
    @objc private func handleCloseButtonTap() {
        UIView.animate(withDuration: 0.3, animations: {
            self.closeView.alpha = 0
        }, completion: { _ in
            if let copyImageView = self.view.subviews.last as? UIImageView {
                UIView.animate(withDuration: 0.5, animations: {
                    copyImageView.frame = self.profileHeaderView.getAvatarImageView().superview?.convert(self.profileHeaderView.getAvatarImageView().frame, to: nil) ?? .zero
                    self.overlayView.alpha = 0
                }, completion: { _ in
                    copyImageView.removeFromSuperview()
                })
            }
        })
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        2
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        section == 0 ? 1 : data.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        if (indexPath.section == 0) {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PhotoTableViewCell.identifier,
                for: indexPath
            ) as? PhotoTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }
            
            cell.onPhotoSelected = { [weak self] indexPath in
                let photosViewController = PhotosViewController()
                self?.navigationController?.pushViewController(photosViewController, animated: true)
            }
            
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "custom",
                for: indexPath
            ) as? PostTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }
            
            cell.update(data[indexPath.row])
            
            return cell
        }
    }
}

extension ProfileViewController: UITableViewDelegate {}
