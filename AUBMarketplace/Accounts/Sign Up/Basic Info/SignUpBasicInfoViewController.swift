//
//  SignUpBasicInfoViewController.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 12/28/20.
//

import UIKit

class SignUpBasicInfoViewController: UIViewController {
    
    var basicInfoView: SignUpBasicInfoView!
    var textFieldsDelegate: SequentialTextFieldDelegate!
    
    override func loadView() {
        basicInfoView = SignUpBasicInfoView(continueAction: didTapContinueButton)
        view = basicInfoView
        view.backgroundColor = .systemBackground
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Subscribe to the keyboardShow notification to modify the continue button's bottomAnchor constraint
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handle(keyboardShowNotification:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        setupTextFields()
        
    }
    
    private func setupTextFields() {
        textFieldsDelegate = SequentialTextFieldDelegate(textFields: [
            basicInfoView.firstNameTextField,
            basicInfoView.lastNameTextField,
            basicInfoView.phoneTextField,
        ], finishButton: basicInfoView.continueButton)
        
        basicInfoView.firstNameTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    /*
    1. Simply print Keyboard show notification to make sure that this method is being called when the keyboard is shown.
    2. We use an if let to ensure that notification.userInfo is not nil.
    3. If it is not nil we will try and get the keyboards frame. To do this we use the UIResponder.keyboardFrameEndUserInfoKey key. The value for this key is an NSValue, but we can cast it to a CGRect immediately. This CGRect will contain the frame of the keyboard.
     */
    @objc
    private func handle(keyboardShowNotification notification: Notification) {

        if let userInfo = notification.userInfo,
            let keyboardRectangle = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            
            moveButtonUp(keyboardHeight: keyboardRectangle.height)
            
        }
    }
    
    private func moveButtonUp(keyboardHeight: CGFloat) {
        basicInfoView.buttonBottomConsraint.constant = -keyboardHeight-20
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(5),
                       initialSpringVelocity: CGFloat(10),
                       options: [.curveEaseOut],
                       animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)

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
