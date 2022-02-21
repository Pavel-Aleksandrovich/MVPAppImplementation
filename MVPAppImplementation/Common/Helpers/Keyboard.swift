//
//  Keyboard.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 21.02.2022.
//

import Foundation
import UIKit

enum MoveKeyboard {
    case keyboardWillShow
    case keyboardWillHide
}

final class Keyboard {
    
    typealias ComplitionHandler = (_ moveKeyboard: MoveKeyboard, _ keyboardFrame: CGRect) -> Void
    
    let complitionHandler: ComplitionHandler
    
    init(complitionHandler: @escaping ComplitionHandler) {
        self.complitionHandler = complitionHandler
        registerKeyboardNotification()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func registerKeyboardNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func handler(notification: Notification, moveKeyboard: MoveKeyboard) {
        let userInfo = notification.userInfo
        guard let keyboardFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        complitionHandler(moveKeyboard, keyboardFrame)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        handler(notification: notification, moveKeyboard: .keyboardWillShow)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        handler(notification: notification, moveKeyboard: .keyboardWillHide)
    }
}
