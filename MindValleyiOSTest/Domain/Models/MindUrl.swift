//
//  MindUrl.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/01/2020.
//  Copyright © 2020 MindValley. All rights reserved.
//

import Foundation

struct MindUrl: Codable {
    var raw: String
    var full: String
    var regular: String
    var small: String
    var thumb: String
    
    enum CodingKeys: String, CodingKey {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}
