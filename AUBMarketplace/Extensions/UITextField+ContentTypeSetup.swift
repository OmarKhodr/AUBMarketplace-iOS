//
//  UITextField+ContentTypeSetup.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/3/21.
//

import UIKit

extension UITextField {
    
    func setupForNameContent() {
        textContentType = .name
        autocapitalizationType = .words
        autocorrectionType = .no
        keyboardType = .alphabet
    }
    
    func setupForEmailContent() {
        textContentType = .emailAddress
        keyboardType = .emailAddress
        autocorrectionType = .no
        autocapitalizationType = .none
        adjustsFontSizeToFitWidth = true;
        minimumFontSize = 10.0; //Optionally specify min size
    }
    
    func setupForPasswordContent() {
        textContentType = .password
        autocorrectionType = .no
        autocapitalizationType = .none
        isSecureTextEntry = true
    }
    
    func setupForNewPasswordContent() {
        textContentType = .newPassword
        autocorrectionType = .no
        autocapitalizationType = .none
        isSecureTextEntry = true
    }
    
    func setupForPhoneContent() {
        textContentType = .telephoneNumber
        keyboardType = .phonePad
    }
    
    func setupForCompanyContent() {
        textContentType = .organizationName
        autocapitalizationType = .words
        autocorrectionType = .no
        keyboardType = .alphabet
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 10.0 //Optionally specify min size
    }
    
    func setupForPriceContent() {
        keyboardType = .numberPad
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 10.0
    }
    
}
