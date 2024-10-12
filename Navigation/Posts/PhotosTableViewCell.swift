//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 10/10/24.
//

import Foundation
import UIKit

class PhotosTableViewCell: UITableViewCell {
    static let identifier = "PhotosTableViewCell"
    
    private let photoViewController = ProfilePhotosViewController()
        
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        setupView()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(photoViewController.view)
    }
    
    private func setupLayouts() {
        let safeAreaGuide = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            photoViewController.view.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            photoViewController.view.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            photoViewController.view.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            photoViewController.view.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
        ])
    }
}
