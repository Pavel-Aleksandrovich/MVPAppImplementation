//
//  TaskViewRouter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

protocol TaskViewRouter {
    func presentAddTask(addTaskPresenterDelegate: AddTaskPresenterDelegate)
}

class TaskViewRouterImpl: TaskViewRouter {
    var taskListViewController: TaskListViewController?
    var addTaskPresenterDelegate: AddTaskPresenterDelegate?
    
    func presentAddTask(addTaskPresenterDelegate: AddTaskPresenterDelegate) {
        
        self.addTaskPresenterDelegate = addTaskPresenterDelegate
        let vc = AddTaskAssembler.assembly(addTaskPresenterDelegate: addTaskPresenterDelegate)
        taskListViewController?.navigationController?.pushViewController(vc, animated: false)
    }
}
