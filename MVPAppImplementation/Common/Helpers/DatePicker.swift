//
//  DatePicker.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 21.02.2022.
//

import UIKit

final class DatePicker {
    
    private let datePicker = UIDatePicker()
    private let toolbar = UIToolbar()
    private weak var viewController: UIViewController?
    private let textField: UITextField
    
    init(textField: UITextField, viewController: UIViewController) {
        self.textField = textField
        self.viewController = viewController
        configureAppearance()
        configureToolbar()
    }
    
    private func configureAppearance() {
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        datePicker.datePickerMode = .dateAndTime
        
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
    }
    
    private func configureToolbar() {
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        
        toolbar.sizeToFit()
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
    }
    
    @objc private func doneButtonTapped() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy, h:mm a"
        textField.text = formatter.string(from: datePicker.date)
        viewController?.view.endEditing(true)
    }
    
    @objc private func cancelButtonTapped() {
        viewController?.view.endEditing(true)
    }
}
