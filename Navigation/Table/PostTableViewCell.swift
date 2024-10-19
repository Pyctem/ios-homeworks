//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 03/10/24.
//

import Foundation
import UIKit
import StorageService
import iOSIntPackage

class PostTableViewCell: UITableViewCell {
    private lazy var postTitle: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        
        return label;
    }()
    
    private lazy var postImage: UIImageView = {
        let image = UIImageView()
        
        image.backgroundColor = .black
        image.contentMode = .scaleAspectFit
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private lazy var postDescription: UILabel = {
        let text = UILabel()
        
        text.font = UIFont.systemFont(ofSize: 14)
        text.textColor = .systemGray
        text.numberOfLines = 0
        
        text.translatesAutoresizingMaskIntoConstraints = false
        
        return text
    }()
    
    private lazy var postLikes: UILabel = {
        let likes = UILabel()
        
        likes.font = UIFont.systemFont(ofSize: 16)
        likes.textColor = .black
        
        likes.translatesAutoresizingMaskIntoConstraints = false
        
        return likes
    }()
    
    private lazy var postViews: UILabel = {
        let views = UILabel()
        
        views.font = UIFont.systemFont(ofSize: 16)
        views.textColor = .black
        
        views.translatesAutoresizingMaskIntoConstraints = false
        
        return views;
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        
        tuneView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tuneView() {
        accessoryType = .none
    }
    
    private func addSubviews() {
        contentView.addSubview(postTitle)
        contentView.addSubview(postImage)
        contentView.addSubview(postDescription)
        contentView.addSubview(postLikes)
        contentView.addSubview(postViews)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            postTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.topAnchor.constraint(equalTo: postTitle.bottomAnchor, constant: 16),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor),

            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
            
            postLikes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            postLikes.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16.0),
            postLikes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            postViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            postViews.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: 16.0),
            postViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
    
    func update(_ model: PostItem) {
        postTitle.text = model.author;
        postImage.image = UIImage(named: model.image)
        postDescription.text = model.description
        postLikes.text = String(model.likes)
        postViews.text = String(model.views)
        
        let ip = ImageProcessor()
        
        ip.processImage(sourceImage: UIImage(named: model.image)!, filter: .tonal, completion: { img in postImage.image = img })
    }
}
