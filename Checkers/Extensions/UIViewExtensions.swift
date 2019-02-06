//
//  UIViewExtensions.swift
//  Checkers
//
//  Created by Satish Boggarapu on 2/5/19.
//  Copyright © 2019 SatishBoggarapu. All rights reserved.
//

import UIKit

extension UIView {
    
    func addShadow(cornerRadius: CGFloat = 2, offset: CGSize = CGSize(width: 0, height: 2), opacity: Float = 0.3, shadowRadius: CGFloat = 2, color: CGColor = UIColor.black.cgColor) {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowColor = color
    }
    
    func roundCorners(_ corners: UIRectCorner, _ radii: CGFloat) {
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.layer.bounds
        maskLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii)).cgPath
        self.layer.mask = maskLayer
    }
    
    func clearConstraints() {
        for subview in self.subviews {
            subview.clearConstraints()
        }
        self.removeConstraints(self.constraints)
    }
}
