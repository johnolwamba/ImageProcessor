//
//  User.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/01/2020.
//  Copyright © 2020 MindValley. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: String
    var username: String
    var name: String
    var profileImage: String
    var links: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case profileImage = "profile_image"
        case links
    }
}

