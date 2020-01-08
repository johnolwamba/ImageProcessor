//
//  UITableView+Mind.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/01/2020.
//  Copyright © 2020 MindValley. All rights reserved.
//

import UIKit

extension UITableView {
    func register(_ identifier: String) {
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }

    func adjustInsets(_ insets: UIEdgeInsets) {
        contentInset = insets
        scrollIndicatorInsets = insets
    }
    
    func scrollLoader(_ show: Bool) {
        if show && tableFooterView == nil {
            let activityIndicatorView = UIActivityIndicatorView(style: .white)
            activityIndicatorView.color = .purple
            activityIndicatorView.startAnimating()
            activityIndicatorView.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: bounds.width, height: CGFloat(44))
            tableFooterView = activityIndicatorView
            tableFooterView?.isHidden = false
        } else if !show {
            tableFooterView = nil
        }
    }
}

