//
//  AddTaskRouter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

protocol AddTaskRouter {
    
}

class AddTaskRouterImpl: AddTaskRouter {
    
    var addTaskView: AddTaskView?
    var presenter: AddTaskPresenter?
    
}
