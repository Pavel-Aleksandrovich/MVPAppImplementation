//
//  TaskViewRouter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

protocol TaskViewRouter {
    func presentAddTask(view: TaskListViewController, animated: Bool,
                        addTaskPresenterDelegate: AddTaskPresenterDelegate)
    
    func presentTaskDetail(view: TaskListViewController, task: TaskEntity, animated: Bool,
                           deleteComplition: @escaping (TaskEntity) -> ())
}

class TaskViewRouterImpl: TaskViewRouter {
    
    func presentAddTask(view: TaskListViewController, animated: Bool,
                        addTaskPresenterDelegate: AddTaskPresenterDelegate) {
        
        let vc = AddTaskAssembler.assembly(addTaskPresenterDelegate: addTaskPresenterDelegate)
        view.navigationController?.pushViewController(vc, animated: animated)
    }
    
    func presentTaskDetail(view: TaskListViewController,
                           task: TaskEntity,
                           animated: Bool,
                           deleteComplition: @escaping (TaskEntity) -> ()) {
        
        let vc = TaskDetailAssembler.assembly(task: task, deleteComplition: deleteComplition)
        view.navigationController?.pushViewController(vc, animated: animated)
    }
}
