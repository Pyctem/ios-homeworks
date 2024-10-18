//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 17/07/24.
//

import Foundation
import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cat")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hipster Cat"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Listening to music"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let statusTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your status"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = true
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let setStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Set status", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        return button
    }()
    
    private var statusText: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        tuneView()
        addViews()
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(
            width: UIView.noIntrinsicMetric,
            height: 200
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tuneView() {
        backgroundColor = .secondarySystemBackground
    }
    
    private func addViews() {
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(setStatusButton)
        
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.width.height.equalTo(100)
        }
        
        fullNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(27)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.top.equalTo(fullNameLabel.snp.bottom).offset(8)
        }
        
        statusTextField.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(statusLabel.snp.bottom).offset(8)
            make.height.equalTo(40)
        }
        
        setStatusButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func getAvatarImageView() -> UIImageView {
        return avatarImageView
    }
}
