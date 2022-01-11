//
//  TaskDetailRouter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

protocol TaskDetailRouter {
    func popViewController(view: TaskDetailViewController, animated: Bool)
}

class TaskDetailRouterImpl: TaskDetailRouter {
    
    func popViewController(view: TaskDetailViewController, animated: Bool) {
        view.navigationController?.popViewController(animated: animated)
    }
}
