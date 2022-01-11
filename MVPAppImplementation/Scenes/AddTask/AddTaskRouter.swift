//
//  AddTaskRouter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

protocol AddTaskRouter {
    func popViewController(animated: Bool)
}

class AddTaskRouterImpl: AddTaskRouter {
    
    var addTaskView: AddTaskViewController?
    var presenter: AddTaskPresenter?
    
    func popViewController(animated: Bool) {
        addTaskView?.navigationController?.popViewController(animated: animated)
    }
}
