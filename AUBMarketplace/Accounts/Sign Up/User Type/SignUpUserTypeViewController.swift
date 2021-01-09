//
//  SignUpUserTypeViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/29/20.
//

import UIKit

class SignUpUserTypeViewController: UIViewController {
    
    let basicUser: BasicUser
    
    init(basicUser: BasicUser) {
        self.basicUser = basicUser
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = SignUpUserTypeView(userTypeAction: didChooseUserType(userType:))
        view.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - Actions Setup
extension SignUpUserTypeViewController {
    private func didChooseUserType(userType: UserType) {
        let credentialsVC = SignUpCredentialsViewController(basicUser: basicUser,
                                                            userType: userType)
        show(credentialsVC, sender: self)
    }
}
