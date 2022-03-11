//
//  Keyboard.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 21.02.2022.
//

import Foundation
import UIKit

final class Keyboard {
    
    private var scrollViewLayoutConstraint: NSLayoutConstraint?
    private let scrollView: UIScrollView
    private weak var viewController: UIViewController?
    
    init(scrollView: UIScrollView, viewController: UIViewController) {
        self.scrollView = scrollView
        self.viewController = viewController
        registerKeyboardNotification()
        configureLayout()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func registerKeyboardNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        guard let keyboardFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        showKeyboard(keyboardFrame: keyboardFrame)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        hideKeyboard()
    }
    
    private func showKeyboard(keyboardFrame: CGRect) {
        if scrollViewLayoutConstraint?.constant == 0 {
            let keyboardTop = keyboardFrame.height
            scrollViewLayoutConstraint?.constant = -keyboardTop
            scrollView.contentOffset = CGPoint(x: 0, y: keyboardTop)
        }
    }
    
    private func hideKeyboard() {
        if scrollViewLayoutConstraint?.constant != 0 {
            scrollViewLayoutConstraint?.constant = 0
            scrollView.contentOffset = CGPoint.zero
        }
    }
    
    private func configureLayout() {
        scrollViewLayoutConstraint = scrollView.bottomAnchor.constraint(
            equalTo: (viewController?.view.bottomAnchor)!, constant: 0)
        scrollViewLayoutConstraint?.isActive = true
    }
        
}
