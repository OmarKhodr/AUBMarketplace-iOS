//
//  SignUpBasicInfoViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/28/20.
//

import UIKit

class SignUpBasicInfoViewController: UIViewController {
    
    var basicInfoView: SignUpBasicInfoView!
    
    override func loadView() {
        view = SignUpBasicInfoView(continueAction: didTapContinueButton)
        view.backgroundColor = .systemBackground
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        basicInfoView = view as? SignUpBasicInfoView
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handle(keyboardShowNotification:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        setupTextFields()
        
    }
    
    private func setupTextFields() {
        basicInfoView.firstNameTextField.delegate = self
        basicInfoView.firstNameTextField.tag = 1
        
        basicInfoView.lastNameTextField.delegate = self
        basicInfoView.lastNameTextField.tag = 2
        
        basicInfoView.phoneTextField.delegate = self
        basicInfoView.phoneTextField.tag = 3
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        basicInfoView.firstNameTextField.becomeFirstResponder()
    }

//    private func moveButtonUp(keyboardHeight: CGFloat) {
//        let basicInfoView = view as! SignUpBasicInfoView
//        NSLayoutConstraint.deactivate([
//            basicInfoView.continueButton.bottomAnchor.constraint(equalTo: basicInfoView.safeAreaLayoutGuide.bottomAnchor, constant: -20)
//        ])
//        print(basicInfoView.constraints)
//        NSLayoutConstraint.activate([
//            basicInfoView.continueButton.bottomAnchor.constraint(equalTo: basicInfoView.bottomAnchor, constant: -keyboardHeight-20)
//        ])
//    }
    
    
    /*
    1. Simply print Keyboard show notification to make sure that this method is being called when the keyboard is shown.
    2. We use an if let to ensure that notification.userInfo is not nil.
    3. If it is not nil we will try and get the keyboards frame. To do this we use the UIResponder.keyboardFrameEndUserInfoKey key. The value for this key is an NSValue, but we can cast it to a CGRect immediately. This CGRect will contain the frame of the keyboard.
     */
    @objc
    private func handle(keyboardShowNotification notification: Notification) {
        // 1
        print("Keyboard show notification")

        // 2
        if let userInfo = notification.userInfo,
            // 3
            let keyboardRectangle = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            print(keyboardRectangle.height)
//            moveButtonUp(keyboardHeight: keyboardRectangle.height)
        }
    }

}

//MARK: - Action Setup
extension SignUpBasicInfoViewController {
    private func didTapContinueButton() {
        if let basicUser = createBasicUser() {
            let userTypeVC = SignUpUserTypeViewController(basicUser: basicUser)
            show(userTypeVC, sender: self)
        } else {
            //error
        }
    }
    
    private func createBasicUser() -> BasicUser? {
        guard
            let firstName = basicInfoView.firstNameTextField.text,
            let lastName = basicInfoView.lastNameTextField.text,
            let phoneNumber = basicInfoView.phoneTextField.text
        else {
            return nil
        }
        
        let basicUser = BasicUser(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        return basicUser
    }
}

//MARK: - UITextFieldDelegate Methods
extension SignUpBasicInfoViewController: UITextFieldDelegate {
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
