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
}
