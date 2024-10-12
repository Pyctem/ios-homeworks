//
//  PhotosViewCell.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 10/10/24.
//

import Foundation
import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    static var identifier = "PhotoCollectionViewCell"

    private lazy var photoView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupLayouts()
    }

    private func setupSubviews() {
        contentView.layer.masksToBounds = true
        contentView.addSubview(photoView)
    }

    private func setupLayouts() {
        NSLayoutConstraint.activate([
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor)
        ])
    }
    
    func configure(cornerRadius: CGFloat) {
        contentView.layer.cornerRadius = cornerRadius
    }

    func setup(
        with imageName: String
    ) {
        photoView.image = UIImage(named: imageName)
    }
}
