//
//  MainTabBarController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/31/20.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

}

//MARK: - Tab Bar Delegate
extension MainTabBarController: UITabBarControllerDelegate {
    
}
