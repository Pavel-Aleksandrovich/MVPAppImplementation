//
//  AddTaskRouter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

protocol TaskDetailsRouter {
    func popViewController(animated: Bool)
    func presentColorPicker(viewController: UIViewController, animated: Bool,
                            sourceView: UIButton, delegate: TaskDetailsViewController)
    func presentFontPicker(viewController: UIViewController, animated: Bool,
                           sourceView: UIButton, delegate: TaskDetailsViewController)
}

class TaskDetailsRouterImpl: TaskDetailsRouter {
    
    weak var controller: UIViewController?
    
    func popViewController(animated: Bool) {
        controller?.navigationController?.popViewController(animated: animated)
    }
    
    func presentColorPicker(viewController: UIViewController, animated: Bool,
                            sourceView: UIButton, delegate: TaskDetailsViewController) {
        
        let colorPickerViewController = ColorPickerAssembler.assembly(delegate: delegate, sourceView: sourceView)
        
        viewController.present(colorPickerViewController, animated: animated)
    }
    
    func presentFontPicker(viewController: UIViewController, animated: Bool,
                           sourceView: UIButton, delegate: TaskDetailsViewController) {
        
        let fontPickerViewController = FontPickerAssembler.assembly(delegate: delegate, sourceView: sourceView)
        
        viewController.present(fontPickerViewController, animated: animated)
    }
}
