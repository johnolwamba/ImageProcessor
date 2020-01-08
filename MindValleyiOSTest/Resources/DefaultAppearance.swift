//
//  DefaultAppearance.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/01/2020.
//  Copyright © 2020 MindValley. All rights reserved.
//

import UIKit

class DefaultAppearance {
    func configure() {
        configureNavigationBarDefaultAppearance()
    }
    
    private func configureNavigationBarDefaultAppearance() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .blue
        UINavigationBar.appearance().barStyle = .default
        if #available(iOS 11.0, *) {
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue,
                                                                     NSAttributedString.Key.font: UIFont.MindFont.semiBold.font(28)]
        }
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue,
                                                            NSAttributedString.Key.font: UIFont.MindFont.semiBold.font(20)]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue,
                                                             NSAttributedString.Key.font: UIFont.MindFont.semiBold.font(16)], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue,
                                                             NSAttributedString.Key.font: UIFont.MindFont.semiBold.font(16)], for: .highlighted)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                                             NSAttributedString.Key.font: UIFont.MindFont.semiBold.font(16)], for: .disabled)
    
    }
}


