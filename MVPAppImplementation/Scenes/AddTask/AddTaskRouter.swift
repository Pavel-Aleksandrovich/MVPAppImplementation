//
//  AddTaskRouter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

protocol AddTaskRouter {
    func popViewController(view: AddTaskViewController, animated: Bool)
}

class AddTaskRouterImpl: AddTaskRouter {
    
    func popViewController(view: AddTaskViewController, animated: Bool) {
        view.navigationController?.popViewController(animated: animated)
    }
}
