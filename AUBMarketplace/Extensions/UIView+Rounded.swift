//
//  UIView+Rounded.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/7/20.
//

import UIKit

extension UIView {
    func rounded(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
}
