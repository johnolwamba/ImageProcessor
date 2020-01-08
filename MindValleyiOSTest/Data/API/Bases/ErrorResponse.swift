////
//  SafeBodaData
//
//	ErrorResponse.swift written using Swift 4.0
//
//  Created on: 12/03/2019
//
//  Copyright © 2019 SafeBoda. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {
    let code: Int
    let message: String
    let reason: String?
}
