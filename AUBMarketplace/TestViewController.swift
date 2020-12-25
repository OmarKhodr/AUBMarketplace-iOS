//
//  TestViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 11/17/20.
//

import UIKit

class TestViewController: UIViewController {
    
    var product: Product!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        let large = ProductLargeView(with: product)
        view.addSubview(large)
        large.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            large.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            large.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            large.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
        
    }
    
}
