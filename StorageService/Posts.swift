//
//  Posts.swift
//  Navigation
//
//  Created by Рустем Аджигельдиев on 03/10/24.
//

import Foundation

public struct PostItem {
    public let author: String
    public let description: String
    public let image: String
    public let likes: Int
    public let views: Int
}

extension PostItem {
    public static func make() -> [PostItem] {
        [
            PostItem(author: "Joe Doe", description: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto", image: "dohn_doe", likes: 10, views: 20),
            PostItem(author: "Wayne Rooney", description: "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla", image: "wayne_rooney", likes: 15, views: 20),
            PostItem(author: "Luis Figo", description: "et iusto sed quo iure\nvoluptatem occaecati omnis eligendi aut ad\nvoluptatem doloribus vel accusantium quis pariatur\nmolestiae porro eius odio et labore et velit aut", image: "luis_figo", likes: 20, views: 30),
            PostItem(author: "Viktor Tsoy", description: "ullam et saepe reiciendis voluptatem adipisci\nsit amet autem assumenda provident rerum culpa\nquis hic commodi nesciunt rem tenetur doloremque ipsam iure\nquis sunt voluptatem rerum illo velit", image: "viktor_tsoy", likes: 25, views: 35),
        ]
    }
}
