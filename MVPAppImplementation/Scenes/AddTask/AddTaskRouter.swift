//
//  AddTaskRouter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

protocol AddTaskRouter {
    func popViewController(navigationController: UINavigationController?, animated: Bool)
}

class AddTaskRouterImpl: AddTaskRouter {
    
    func popViewController(navigationController: UINavigationController?, animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
}
