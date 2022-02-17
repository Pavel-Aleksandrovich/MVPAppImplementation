//
//  TaskDetailsPopupRouter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 24.01.2022.
//

import UIKit

protocol TaskDetailsPopupRouter {
    func dismissView()
}

final class TaskDetailsPopupRouterImpl: TaskDetailsPopupRouter {
    
    weak var controller: UIViewController?
    
    func dismissView() {
        controller?.dismiss(animated: true)
    }
}
