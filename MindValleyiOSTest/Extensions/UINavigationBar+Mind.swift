//
//  UINavigationBar+Mind.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/01/2020.
//  Copyright © 2020 MindValley. All rights reserved.
//

import UIKit

extension UINavigationBar {
    func largeTitles(enabled: Bool) {
        if #available(iOS 11.0, *) {
            self.prefersLargeTitles = enabled
        }
    }
}
