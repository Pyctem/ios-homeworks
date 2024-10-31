//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 31/10/24.
//

import Foundation
import UIKit


class ProfileViewModel {
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func getUserName() -> String {
        user.username
    }
    
    func getUserStatus() -> String {
        user.status
    }
    
    func getUserAvatar() -> UIImage {
        user.avatar
    }
}
