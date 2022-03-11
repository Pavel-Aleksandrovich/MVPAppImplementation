//
//  AddTaskAssembly.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

final class TaskDetailsAssembler {
    
    class func assembly(state: TaskState) -> UIViewController {
        
        let router = TaskDetailsRouterImpl()
        let taskService = TaskServiceImpl()
        let presenter = TaskDetailsPresenterImpl(router: router, state: state, taskService: taskService)
        let controller = TaskDetailsViewController(presenter: presenter)
        router.controller = controller
        
        return controller
    }
}
