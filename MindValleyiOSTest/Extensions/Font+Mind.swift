//
//  Font+Mind.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/01/2020.
//  Copyright © 2020 MindValley. All rights reserved.
//

import UIKit

extension UIFont {
    enum MindFont: String {
        case regular = "Asap-Regular"
        case semiBold = "Asap-SemiBold"
        
        func font(_ size: CGFloat) -> UIFont {
            guard let font = UIFont(name: self.rawValue, size: size) else {
                return UIFont.systemFont(ofSize: size)
            }
            return font
        }
    }
}
