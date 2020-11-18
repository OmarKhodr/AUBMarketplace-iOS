//
//  UIButton+Animate.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/16/20.
//

import UIKit

//source: https://www.roryba.in/programming/swift/2018/03/24/animating-uibutton.html

extension UIControl {
    
    func startAnimatingPressActions() {
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    @objc private func animateDown(sender: UIControl) {
        animate(sender, transform: CGAffineTransform(scaleX: 0.95, y: 0.95))
    }
    
    @objc private func animateUp(sender: UIControl) {
        animate(sender, transform: .identity)
    }
    
    private func animate(_ control: UIControl, transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                        control.transform = transform
            }, completion: nil)
    }
    
}

//extension UIButton {
//
//    func startAnimatingPressActions() {
//        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
//        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
//    }
//
//    @objc private func animateDown(sender: UIButton) {
//        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95))
//    }
//
//    @objc private func animateUp(sender: UIButton) {
//        animate(sender, transform: .identity)
//    }
//
//    private func animate(_ button: UIButton, transform: CGAffineTransform) {
//        UIView.animate(withDuration: 0.4,
//                       delay: 0,
//                       usingSpringWithDamping: 0.5,
//                       initialSpringVelocity: 3,
//                       options: [.curveEaseInOut],
//                       animations: {
//                        button.transform = transform
//            }, completion: nil)
//    }
//
//}
