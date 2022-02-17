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
    
    // MARK: - Shake animation for title text field
    
    func showShakeAnimation(textField: UITextField) {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "position.x")
        shakeAnimation.values = [0, -15, 15, -15, 15, 0]
        shakeAnimation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
        shakeAnimation.duration = 0.4
        shakeAnimation.isAdditive = true
        textField.layer.add(shakeAnimation, forKey: nil)
    }
    
    // MARK: - Enum for Context Menu
    
    enum ContextMenuActions {
        case edit
        case deleteConfirmation
        case showDetails
    }
    
    // MARK: - Context Menu Configuration
    
    func contextMenuConfiguration(complition: @escaping (ContextMenuActions) -> ()) -> UIContextMenuConfiguration {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) {suggestedActions in
            
            // Create an action for sharing
            let showDetails = UIAction(title: "Show Details", image: UIImage(systemName: "square.and.arrow.up")) { action in
                complition(.showDetails)
            }
            
            // Create an action for editing
            let edit = UIAction(title: "Edit", image: UIImage(systemName: "square.and.pencil")) { action in
                complition(.edit)
            }
            
            // Here we specify the "destructive" attribute to show that it’s destructive in nature
            
            let deleteCancel = UIAction(title: "Cancel", image: UIImage(systemName: "xmark")) { action in }
            let deleteConfirmation = UIAction(title: "Delete", image: UIImage(systemName: "checkmark"), attributes: .destructive) { action in
                complition(.deleteConfirmation)
            }
            
            let delete = UIMenu(title: "Delete", image: UIImage(systemName: "trash"), children: [deleteCancel, deleteConfirmation])
            
            // Create and return a UIMenu with all of the actions as children
            return UIMenu(title: "", children: [showDetails, edit, delete])
        }
    }
}
