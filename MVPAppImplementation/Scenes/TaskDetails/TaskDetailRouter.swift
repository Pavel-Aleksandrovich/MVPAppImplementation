//
//  TaskDetailRouter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

protocol TaskDetailRouter {
    func popViewController(animated: Bool)
    func set(navigationController: UINavigationController?)
}

final class TaskDetailRouterImpl: TaskDetailRouter {
    
    private var navigationController: UINavigationController?
    
    func set(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func popViewController(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
}
