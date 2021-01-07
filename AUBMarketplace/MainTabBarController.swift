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
        tabBar.tintColor = .systemGreen
        delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let productsNavController = UINavigationController(rootViewController: ProductsFeedViewController())
        let productsIcon = UITabBarItem(title: "Products", image: UIImage(systemName: "cart.fill"), tag: 0)
        productsNavController.tabBarItem = productsIcon
        
        let servicesNavController = UINavigationController(rootViewController: ServicesListViewController())
        let servicesIcon = UITabBarItem(title: "Services", image: UIImage(systemName: "figure.wave"), tag: 1)
        servicesNavController.tabBarItem = servicesIcon
        
        let meNavController = UINavigationController(rootViewController: ProfileViewController())
        let meIcon = UITabBarItem(title: "Me", image: UIImage(systemName: "person.crop.circle"), tag: 2)
        meNavController.tabBarItem = meIcon
        
        self.viewControllers = [productsNavController, servicesNavController, meNavController]
    }

}

//MARK: - Tab Bar Delegate
extension MainTabBarController: UITabBarControllerDelegate {
    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true;
    }
}
