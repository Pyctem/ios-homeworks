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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: nil)
        view.backgroundColor = .lightGray
        
        addSubviews()
        setupConstraints()
        tuneTableView()
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
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
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
