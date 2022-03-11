//
//  TaskViewRouter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

protocol TaskListRouter {
    func presentTaskDetails(animated: Bool, state: TaskState)
    func presentTaskDetailsPopup(index: Int)
}

final class TaskListRouterImpl: TaskListRouter {
    
    weak var controller: UIViewController?
    
    func presentTaskDetails(animated: Bool, state: TaskState) {
        
        let vc = TaskDetailsAssembler.assembly(state: state)
        controller?.navigationController?.pushViewController(vc, animated: animated)
    }
    
    func presentTaskDetailsPopup(index: Int) {
        let pop = TaskDetailsPopupAssembler.assembly(taskIndex: index)
        controller?.present(pop, animated: true)
    }
}
