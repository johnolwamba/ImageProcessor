//
//  Category.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/01/2020.
//  Copyright © 2020 MindValley. All rights reserved.
//

import Foundation

struct Category: Codable {
    var id: Int
    var title: String
    var photoCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case photoCount = "photo_count"
    }
}
