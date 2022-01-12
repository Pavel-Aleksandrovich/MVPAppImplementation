//
//  TaskViewRouter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

protocol TaskViewRouter {
    func presentAddTask(view: TaskListViewController,
                        addTaskPresenterDelegate: AddTaskPresenterDelegate)
    func presentTaskDetail(view: TaskListViewController, task: TaskEntity,
                           deleteComplition: @escaping (TaskEntity) -> ())
}

class TaskViewRouterImpl: TaskViewRouter {
    
    var addTaskPresenterDelegate: AddTaskPresenterDelegate?
    
    func presentAddTask(view: TaskListViewController,
                        addTaskPresenterDelegate: AddTaskPresenterDelegate) {
        
        self.addTaskPresenterDelegate = addTaskPresenterDelegate
        let vc = AddTaskAssembler.assembly(addTaskPresenterDelegate: addTaskPresenterDelegate)
        view.navigationController?.pushViewController(vc, animated: false)
    }
    
    func presentTaskDetail(view: TaskListViewController, task: TaskEntity,
                           deleteComplition: @escaping (TaskEntity) -> ()) {
        let vc = TaskDetailAssembler.assembly(task: task, deleteComplition: deleteComplition)
        view.navigationController?.pushViewController(vc, animated: false)
    }
}
