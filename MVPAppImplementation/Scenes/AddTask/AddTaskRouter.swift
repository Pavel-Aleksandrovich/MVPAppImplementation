//
//  AddTaskRouter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

protocol AddTaskRouter {
    func popViewController(navigationController: UINavigationController?, animated: Bool)
    func presentColorPicker(viewController: UIViewController, animated: Bool,
                            sourceView: UIButton, delegate: AddTaskViewController)
    func presentFontPicker(viewController: UIViewController, animated: Bool,
                           sourceView: UIButton, delegate: AddTaskViewController)
}

class AddTaskRouterImpl: AddTaskRouter {
    
    func popViewController(navigationController: UINavigationController?, animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    
    func presentColorPicker(viewController: UIViewController, animated: Bool,
                            sourceView: UIButton, delegate: AddTaskViewController) {
        
        let colorPickerViewController = ColorPickerAssembler.assembly(delegate: delegate, sourceView: sourceView)
        
        viewController.present(colorPickerViewController, animated: animated)
    }
    
    func presentFontPicker(viewController: UIViewController, animated: Bool,
                           sourceView: UIButton, delegate: AddTaskViewController) {
        
        let fontPickerViewController = FontPickerAssembler.assembly(delegate: delegate, sourceView: sourceView)
        
        viewController.present(fontPickerViewController, animated: animated)
    }
}
