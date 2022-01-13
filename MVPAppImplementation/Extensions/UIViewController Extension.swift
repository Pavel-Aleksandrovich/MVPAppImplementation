//
//  UIViewController Extension.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 11.01.2022.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(style: UIAlertController.Style, title: String?, message: String?, actions: [UIAlertAction], animated: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alert.addAction(action)
        }
        present(alert, animated: animated)
    }
    
}
