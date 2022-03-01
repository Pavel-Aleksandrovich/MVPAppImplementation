//
//  TaskViewRouter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

protocol TaskListRouter {
    func presentTaskDetails(animated: Bool, index: Int?)
    func presentTaskDetailsPopup(index: Int)
}

final class TaskListRouterImpl: TaskListRouter {
    
    weak var controller: UIViewController?
    
    func presentTaskDetails(animated: Bool, index: Int?) {
        
        let vc = TaskDetailsAssembler.assembly(index: index)
        controller?.navigationController?.pushViewController(vc, animated: animated)
    }
    
    func presentTaskDetailsPopup(index: Int) {
        let pop = TaskDetailsPopupAssembler.assembly(taskIndex: index)
        controller?.present(pop, animated: true)
    }
}
