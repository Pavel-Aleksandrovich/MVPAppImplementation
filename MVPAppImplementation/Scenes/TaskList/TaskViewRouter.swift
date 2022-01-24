//
//  TaskViewRouter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

protocol TaskViewRouter {
    func presentAddTask(navigationController: UINavigationController?, animated: Bool)
    
    func presentTaskDetail(navigationController: UINavigationController?, task: TaskEntity, animated: Bool,
                           deleteComplition: @escaping (TaskEntity) -> ())
}

class TaskViewRouterImpl: TaskViewRouter {
    
    func presentAddTask(navigationController: UINavigationController?, animated: Bool) {
        
        let vc = AddTaskAssembler.assembly()
        navigationController?.pushViewController(vc, animated: animated)
    }
    
    func presentTaskDetail(navigationController: UINavigationController?,
                           task: TaskEntity,
                           animated: Bool,
                           deleteComplition: @escaping (TaskEntity) -> ()) {
        
        let vc = TaskDetailAssembler.assembly(task: task, deleteComplition: deleteComplition)
        navigationController?.pushViewController(vc, animated: animated)
    }
}
