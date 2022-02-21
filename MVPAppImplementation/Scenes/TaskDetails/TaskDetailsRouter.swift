//
//  AddTaskRouter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

protocol TaskDetailsRouter {
    func popViewController(animated: Bool)
    func presentColorPicker(animated: Bool, sourceView: UIButton)
}

final class TaskDetailsRouterImpl: TaskDetailsRouter {
    
    weak var controller: UIViewController?
    
    func popViewController(animated: Bool) {
        controller?.navigationController?.popViewController(animated: animated)
    }
    
    func presentColorPicker(animated: Bool,
                            sourceView: UIButton) {
        
        let colorPickerViewController = ColorPickerAssembler.assembly(delegate: controller as! ColorPickerDelegate, sourceView: sourceView)
        
        controller?.present(colorPickerViewController, animated: animated)
    }
}
