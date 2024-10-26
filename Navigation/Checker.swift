//
//  Checker.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 21/10/24.
//

import Foundation

class Checker {
    private let login: String = "MyLogin"
    private let password: String = "MyPassword"
    
    static let shared: Checker = {
        let instance = Checker()
        
        return instance;
    }()
    
    private init() {}
    
    func check(login userLogin: String, password userPassword: String) -> Bool {
        return userLogin == login && userPassword == password
    }
}
