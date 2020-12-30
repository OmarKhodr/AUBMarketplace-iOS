//
//  UITableView+AnimatedDeselection.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/26/20.
//

import UIKit

// Animate selected row's deselection animation when pushing a VC on top of the table view and
// returning from it, nice animation and accessibility feature!
// source: https://twitter.com/JordanMorgan10/status/1266717673053917184

extension UITableView {
    func deselectedRow(withCoordinator coordinator: UIViewControllerTransitionCoordinator?) {
        guard let selectedIndexPath = indexPathsForSelectedRows?.first else { return }

        if let transitionCTX = coordinator {
            
            transitionCTX.animate { (ctx) in
                self.deselectRow(at: selectedIndexPath, animated: true)
            } completion: { (ctx) in
                if ctx.isCancelled {
                    self.selectRow(at: selectedIndexPath, animated: true, scrollPosition: .bottom)
                }
            }

        } else {
            
            self.deselectRow(at: selectedIndexPath, animated: true)
            
        }
    }
}
