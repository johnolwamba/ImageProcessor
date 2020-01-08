//
//  MindErrors.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/08/2019.
//  Copyright © 2019 MindValley. All rights reserved.
//

import Foundation

public enum MindErrors: Error {
    case genericError
    case internetError
    case fileNotFound
    case localUserNotFound
    case dataBaseError
    case apiError(code: Int, message: String, reason: String)
    case retryError(message: String, retryAction: (() -> Void))
    case elementNotFound
    case unauthorized
    case userNotFound
    case invalidPin
    case pinDoNotMatch
}
