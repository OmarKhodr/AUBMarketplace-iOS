//
//  TestViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 16/01/2021.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = User(data: UserData(name: "Omar Khodr",
                                       email: "ohk04@mail.aub.edu",
                                       number: 123,
                                       major: "CSE"))
        let test = SmallProfileView(with: user)
        test.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(test)
        NSLayoutConstraint.activate([
//            test.heightAnchor.constraint(equalToConstant: 100),
//            test.widthAnchor.constraint(equalToConstant: 100),
            test.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            test.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
        // Do any additional setup after loading the view.
    }
    

    

}
