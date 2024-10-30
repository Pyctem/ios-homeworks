//
//  FeedModel.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 28/10/24.
//

import Foundation


class FeedModel {
    var secretWord = "secret";
    
    func check(_ word: String) -> Bool {
        !word.isEmpty && word == secretWord
    }
}
