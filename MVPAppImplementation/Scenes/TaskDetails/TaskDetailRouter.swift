//
//  TaskDetailRouter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

protocol TaskDetailRouter {
    func popViewController(animated: Bool, navigationController: UINavigationController?)
}

final class TaskDetailRouterImpl: TaskDetailRouter {
    func popViewController(animated: Bool, navigationController: UINavigationController?) {
        navigationController?.popViewController(animated: animated)
    }
}
