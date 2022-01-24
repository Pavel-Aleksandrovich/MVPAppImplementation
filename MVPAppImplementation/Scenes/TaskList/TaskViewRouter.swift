//
//  TaskViewRouter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

protocol TaskViewRouter {
    func presentAddTask(navigationController: UINavigationController?, animated: Bool)
    
    func presentTaskDetail(navigationController: UINavigationController?,
                           indexForTaskDetails: Int,
                           animated: Bool)
}

class TaskViewRouterImpl: TaskViewRouter {
    
    func presentAddTask(navigationController: UINavigationController?, animated: Bool) {
        
        let vc = AddTaskAssembler.assembly()
        navigationController?.pushViewController(vc, animated: animated)
    }
    
    func presentTaskDetail(navigationController: UINavigationController?,
                           indexForTaskDetails: Int,
                           animated: Bool) {
        
        let vc = TaskDetailAssembler.assembly(indexForTaskDetails: indexForTaskDetails)
        navigationController?.pushViewController(vc, animated: animated)
    }
}
