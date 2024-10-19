//
//  User.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 19/10/24.
//

import Foundation
import UIKit

protocol UserService {
    func getUser(by login: String) -> User?
}

class User {
    var username: String
    var fullName: String
    var avatar: UIImage
    var status: String
    
    init(username: String, fullName: String, avatar: UIImage, status: String) {
        self.username = username
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}
