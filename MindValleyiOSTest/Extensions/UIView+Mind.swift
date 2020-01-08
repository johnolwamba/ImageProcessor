//
//  UIView+Mind.swift
//  MindValleyiOSTest
//
//  Created by Johnstone Ananda on 06/01/2020.
//  Copyright © 2020 MindValley. All rights reserved.
//

import UIKit

extension UIView {
    func addCornerRadiusAndShadow(_ cornerRadius: CGFloat = 10, _ shadowSize: CGFloat = 1) {
        layer.cornerRadius = cornerRadius
        addShadow(shadowSize)
    }
    
    func addCornerRadius(_ radius: CGFloat = 10) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    func addShadow(_ size: CGFloat = 1) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: size, height: size)
        layer.shadowOpacity = 0.3
    }
    
    func addCornerRadius(_ corners: UIRectCorner, _ radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    
    func pinToSuperview(withEdges edges: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: edges.left),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -edges.right),
            topAnchor.constraint(equalTo: superView.topAnchor, constant: edges.top),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -edges.bottom)
        ])
    }
}

