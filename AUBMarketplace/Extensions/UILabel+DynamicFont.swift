//
//  UILabel+DynamicFont.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/17/20.
//

import UIKit

extension UILabel {
    func setDynamicFont(forTextStyle textStyle: UIFont.TextStyle, weight: UIFont.Weight = .regular) {
        let size = UIFont.preferredFont(forTextStyle: textStyle).pointSize
        let font = UIFont.systemFont(ofSize: size, weight: weight)
        self.font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
        self.adjustsFontForContentSizeCategory = true
    }
    
    func setDynamicFont(forTextStyle textStyle: UIFont.TextStyle, font: UIFont) {
        self.font = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
        self.adjustsFontForContentSizeCategory = true
    }
}
