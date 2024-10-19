//
//  TestUserService.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 19/10/24.
//

import Foundation
import UIKit

class TestUserService: UserService {
    private let testUser: User
    
    init() {
        let testAvatar = UIImage(named: "logo") ?? UIImage()
        self.testUser = User(username: "test_user", fullName: "Test User", avatar: testAvatar, status: "Testing status")
    }
    
    func getUser(by login: String) -> User? {
        return login == testUser.username ? testUser : nil
    }
}
