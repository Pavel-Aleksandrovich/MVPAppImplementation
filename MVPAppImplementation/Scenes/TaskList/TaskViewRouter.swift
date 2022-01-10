//
//  TaskViewRouter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

protocol TaskViewRouter {
    func presentAddTask(addTaskPresenterDelegate: AddTaskPresenterDelegate)
    func presentTaskDetail(task: TaskEntity)
}

class TaskViewRouterImpl: TaskViewRouter {
    var taskListViewController: TaskListViewController?
    var addTaskPresenterDelegate: AddTaskPresenterDelegate?
    var tasks: TaskEntity!
    
    func presentAddTask(addTaskPresenterDelegate: AddTaskPresenterDelegate) {
        
        self.addTaskPresenterDelegate = addTaskPresenterDelegate
        let vc = AddTaskAssembler.assembly(addTaskPresenterDelegate: addTaskPresenterDelegate)
        taskListViewController?.navigationController?.pushViewController(vc, animated: false)
    }
    
    func presentTaskDetail(task: TaskEntity) {
        let vc = TaskDetailAssembler.assembly(task: task)
        taskListViewController?.navigationController?.pushViewController(vc, animated: false)
    }
}
