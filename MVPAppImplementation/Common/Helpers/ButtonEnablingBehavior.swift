//
//  ButtonEnablingBehavior.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.03.2022.
//

import UIKit

final class ButtonEnablingBehavior: NSObject {
    private let textFields: [UITextField]
    private var enable = Bool()
    
    private let onChange: (Bool) -> ()
    
    init(textFields: [UITextField], onChange: @escaping (Bool) -> ()) {
        self.textFields = textFields
        self.onChange = onChange
        super.init()
        checkTextFieldIsEmpty()
        configureTextFieldAction()
    }
    
    private func configureTextFieldAction() {
        textFields.forEach { textField in
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    private func checkTextFieldIsEmpty() {
        for textField in textFields {
            guard let text = textField.text else {return}
            
            if !text.isEmpty {
                enable = true
            } else {
                enable = false
            }
        }
        onChange(enable)
    }
    
    @objc func textFieldDidChange() {
        for textField in textFields {
            guard let text = textField.text else {return}
            
            if !text.isEmpty {
                enable = true
            } else {
                enable = false
            }
        }
        onChange(enable)
    }
}
