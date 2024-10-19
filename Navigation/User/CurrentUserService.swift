//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 19/10/24.
//

import Foundation
import UIKit

class CurrentUserService: UserService {
    private var currentUser: User
    
    init(user: User) {
        self.currentUser = user
    }
    
    func getUser(by login: String) -> User? {
        return currentUser.username == login ? currentUser : nil
    }
}
