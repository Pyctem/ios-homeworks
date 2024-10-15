//
//  ProfilePhotosController.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 12/10/24.
//

import Foundation
import UIKit

final class PhotoTableViewCell: UITableViewCell {
    static let identifier = "PhotosTableViewCell"
    
    var onPhotoSelected: ((_ indexPath: IndexPath) -> Void)?
    
    fileprivate let data = PostItem.make()
        
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout
        )
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier
        )
        
        return collectionView
    }()
    
    private let label: UILabel = {
        
        let label = UILabel();
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Photos"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    private let image: UIImageView = {
        
        let image = UIImageView();
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .black
        
        return image
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        
        setupViews()
        setupCollectionView()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        setupViews()
        setupCollectionView()
        setupLayouts()
        
        accessoryType = .none
    }
    
    private func setupViews() {
        contentView.addSubview(label)
        contentView.addSubview(image)
    }
    
    private func setupCollectionView() {
        contentView.addSubview(collectionView)
        
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func setupLayouts() {        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            image.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            image.widthAnchor.constraint(equalToConstant: 20),
            image.heightAnchor.constraint(equalToConstant: 20),
            
            collectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 12),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
        let heightConstraint = collectionView.heightAnchor.constraint(equalToConstant: calculateCollectionViewHeight())
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
    }
    
    func calculateCollectionViewHeight() -> CGFloat {
        let itemsInRow: CGFloat = 4
        let spacing: CGFloat = 8.0
        let sectionInset: CGFloat = 24.0
        
        let viewWidth = UIScreen.main.bounds.width - 24
        let itemWidth = (viewWidth - ((itemsInRow - 1) * spacing)) / itemsInRow
        let itemHeight = itemWidth
        let collectionViewHeight = itemHeight + sectionInset
        
        return collectionViewHeight
    }
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 8.0
        static let sectionSpacing: CGFloat = 12
    }
}

extension PhotoTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        4
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCollectionViewCell.identifier,
            for: indexPath) as! PhotoCollectionViewCell
        
        let imageName = data[indexPath.row].image;
        
        cell.configure(cornerRadius: 6)
        cell.setup(with: imageName)
        
        return cell
    }
}

extension PhotoTableViewCell: UICollectionViewDelegateFlowLayout {
    
    private func itemWidth(
        for width: CGFloat,
        spacing: CGFloat
    ) -> CGFloat {
        let itemsInRow: CGFloat = 4
        let totalSpacing: CGFloat = (itemsInRow - 1) * spacing + 24
        let finalWidth = (width - totalSpacing) / itemsInRow
        return floor(finalWidth)
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = itemWidth(
            for: contentView.frame.width,
            spacing: LayoutConstant.spacing
        )
        
        return CGSize(width: width, height: width)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(
            top: LayoutConstant.sectionSpacing,
            left: LayoutConstant.sectionSpacing,
            bottom: LayoutConstant.sectionSpacing,
            right: LayoutConstant.sectionSpacing
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        LayoutConstant.spacing
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        LayoutConstant.spacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        onPhotoSelected?(indexPath)
    }
}
