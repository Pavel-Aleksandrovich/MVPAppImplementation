//
//  UIViewController Extension.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 11.01.2022.
//

import UIKit

extension UIViewController {
    
    // MARK: - Hide Keyboard When Tapped Around
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Alert for pick photo from gallery or camera
    
    func showAlert(style: UIAlertController.Style, title: String?, message: String?, actions: [UIAlertAction], animated: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alert.addAction(action)
        }
        present(alert, animated: animated)
    }
    
    // MARK: - Shake animation for title text field
    
    func showShakeAnimation(textField: UITextField) {
//        keyPath: "position.x"
//        keyPath: "position.y"
        let shakeAnimation = CAKeyframeAnimation(keyPath: "position.x")
        shakeAnimation.values = [0, -15, 15, -15, 15, 0]
        shakeAnimation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
        shakeAnimation.duration = 0.4
        shakeAnimation.isAdditive = true
        textField.layer.add(shakeAnimation, forKey: nil)
    }
}
