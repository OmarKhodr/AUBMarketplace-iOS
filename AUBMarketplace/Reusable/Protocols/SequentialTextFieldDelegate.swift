//
//  SequentialTextFieldDelegate.swift
//  AUBMarketplace
//
//  Created by Omar Khodr on 1/8/21.
//

import UIKit

class SequentialTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    let textFields: [UITextField]
    let finishButton: UIButton?
    var ind = 0
    
    init(textFields: [UITextField], finishButton: UIButton? = nil) {
        self.textFields = textFields
        self.finishButton = finishButton
        super.init()
        
        var counter = 0
        
        for textField in textFields {
            textField.tag = counter
            textField.delegate = self
            textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
            counter += 1
        }
    }
    
    @objc private func textDidChange(_ sender: UITextField) {
        var allNonEmpty = true
        
        for tf in textFields {
            if tf.text == "" {
                allNonEmpty = false
                break
            }
        }
        
        finishButton?.isEnabled = allNonEmpty
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if ind+1 < textFields.count {
            ind += 1
            textFields[ind].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
