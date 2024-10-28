//
//  CustomButton.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 28/10/24.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    private var action: ((UIButton) -> Void)?
    
    init(title: String, titleColor: UIColor, action: @escaping (UIButton) -> Void) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.action = action
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped(btn: UIButton) {
        self.action?(btn)
    }
}
