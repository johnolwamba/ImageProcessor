//
//  Image.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/01/2020.
//  Copyright © 2020 MindValley. All rights reserved.
//

import Foundation

struct Image: Codable {
    var id: String
    var createdAt: String
    var width: Int
    var height: Int
    var color: String
    var likes: Int
    var likedByUser: Bool
    var user: User
    var urls: MindUrl
    var category: [Category]
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case width
        case height
        case color
        case likes
        case likedByUser = "liked_by_user"
        case user
        case urls
        case category
    }
}
