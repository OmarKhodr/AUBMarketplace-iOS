//
//  SignUpCredentialsViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/29/20.
//

import UIKit

class SignUpCredentialsViewController: UIViewController {
    
    let basicUser: BasicUser
    let userType: UserType
    
    var credentialsView: SignUpCredentialsView!
    
    var selectedMajorIndex: Int? = nil
    
    let defaults = UserDefaults.standard
    
    init(basicUser: BasicUser, userType: UserType) {
        self.basicUser = basicUser
        self.userType = userType
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = SignUpCredentialsView(userType: userType,
                                     majorAction: majorAction,
                                     continueAction: continueAction)
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        credentialsView = view as? SignUpCredentialsView
        setupTextFields()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        credentialsView.emailTextField.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextFields() {
        credentialsView.emailTextField.delegate = self
        credentialsView.emailTextField.tag = 1
        
        credentialsView.passwordTextField.delegate = self
        credentialsView.passwordTextField.tag = 2
        
        credentialsView.repeatPasswordTextField.delegate = self
        credentialsView.repeatPasswordTextField.tag = 3
    }

}

//MARK: - UITextField Delegate Methods
extension SignUpCredentialsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1

        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return true
    }
}

//MARK: - Action Setup
extension SignUpCredentialsViewController {
    private func majorAction() {
        let options = [
            "CSE",
            "CCE",
            "ECE",
            "ECON"
        ]
        let optionListVC = OptionListViewController(options: options,
                                                    selectedRow: selectedMajorIndex,
                                                    callBack: backFromMajorOptions(selectedMajor:selectedIndex:))
        show(optionListVC, sender: self)
    }
    
    private func backFromMajorOptions(selectedMajor: String?, selectedIndex: Int?) {
        selectedMajorIndex = selectedIndex
        credentialsView.majorListButton.chosenOptionLabel.text = selectedMajor == nil ? "None" : selectedMajor
    }
    
    private func continueAction() {
        if let email = credentialsView.emailTextField.text,
           let password = credentialsView.passwordTextField.text,
           password == credentialsView.repeatPasswordTextField.text,
           let major = credentialsView.majorListButton.chosenOptionLabel.text {
            
            let info = UserInfo(name: "\(basicUser.firstName) \(basicUser.lastName)",
                                email: email,
                                major: major,
                                number: basicUser.phoneNumber,
                                interests: ["programming"],
                                password: password)
            UserManager.shared.createUser(info: info, completion: didCreateUser(token:))
        }
    }
    
    private func didCreateUser(token: UserToken) {
        print("Created User!")
        self.defaults.set(token.token, forKey: "token")
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        let mainTabBar = MainTabBarController()
        self.show(mainTabBar, sender: self)
    }
}
