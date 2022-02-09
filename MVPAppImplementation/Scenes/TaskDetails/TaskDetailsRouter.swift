//
//  AddTaskRouter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

protocol TaskDetailsRouter {
    func popViewController(animated: Bool)
    func presentColorPicker(animated: Bool, sourceView: UIButton, delegate: TaskDetailsViewController)
    func presentFontPicker(animated: Bool, sourceView: UIButton, delegate: TaskDetailsViewController)
}

final class TaskDetailsRouterImpl: TaskDetailsRouter {
    
    weak var controller: UIViewController?
    
    func popViewController(animated: Bool) {
        controller?.navigationController?.popViewController(animated: animated)
    }
    
    func presentColorPicker(animated: Bool,
                            sourceView: UIButton, delegate: TaskDetailsViewController) {
        
        let colorPickerViewController = ColorPickerAssembler.assembly(delegate: delegate, sourceView: sourceView)
        
        controller?.present(colorPickerViewController, animated: animated)
    }
    
    func presentFontPicker(animated: Bool,
                           sourceView: UIButton, delegate: TaskDetailsViewController) {
        
        let fontPickerViewController = FontPickerAssembler.assembly(delegate: delegate, sourceView: sourceView)
        
        controller?.present(fontPickerViewController, animated: animated)
    }
}
