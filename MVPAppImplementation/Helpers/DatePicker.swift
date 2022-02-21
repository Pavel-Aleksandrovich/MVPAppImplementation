//
//  DatePicker.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 21.02.2022.
//

import UIKit

final class DatePicker {
    
    private let picker = UIDatePicker()
    private var viewController: UIViewController
    private let datePickerTextField: UITextField
    
    init(datePickerTextField: UITextField, viewController: UIViewController) {
        self.datePickerTextField = datePickerTextField
        self.viewController = viewController
        pic()
    }
    
    private func pic() {
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
            picker.sizeToFit()
        }
        
        picker.datePickerMode = .dateAndTime
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

        datePickerTextField.inputAccessoryView = toolbar
        datePickerTextField.inputView = picker
    }
    
    @objc private func donedatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy, h:mm a"
        datePickerTextField.text = formatter.string(from: picker.date)
        viewController.view.endEditing(true)
    }
    
    @objc private func cancelDatePicker() {
        viewController.view.endEditing(true)
    }
}
