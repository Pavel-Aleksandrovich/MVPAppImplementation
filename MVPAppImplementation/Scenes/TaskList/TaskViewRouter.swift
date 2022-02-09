//
//  TaskViewRouter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

protocol TaskViewRouter {
    func presentAddTask(animated: Bool, index: Int?)
    
    func presentTaskDetail(navigationController: UINavigationController?,
                           indexForTaskDetails: Int,
                           animated: Bool)
    func presentTaskDetailBylongTouch(index: Int, viewController: UIViewController)
}

class TaskViewRouterImpl: TaskViewRouter {
    
    weak var controller: UIViewController?
    
    func presentAddTask(animated: Bool, index: Int?) {
        
        let vc = AddTaskAssembler.assembly(index: index)
        controller?.navigationController?.pushViewController(vc, animated: animated)
    }
    
    func presentTaskDetail(navigationController: UINavigationController?,
                           indexForTaskDetails: Int,
                           animated: Bool) {
        
        let vc = TaskDetailAssembler.assembly(indexForTaskDetails: indexForTaskDetails)
        navigationController?.pushViewController(vc, animated: animated)
    }
    
    func presentTaskDetailBylongTouch(index: Int, viewController: UIViewController) {
        let pop = TaskDetailsPopupAssembler.assembly(taskIndex: index)
        viewController.present(pop, animated: true)
    }
}
