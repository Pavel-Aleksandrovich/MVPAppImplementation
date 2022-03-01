//
//  Assembly.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 07.01.2022.
//

import UIKit

final class TaskListAssembler {
    
    class func assembly() -> UIViewController {
        
        let router = TaskListRouterImpl()
        let taskService = TaskServiceImpl()
        let presenter = TaskListPresenterImpl(router: router, taskService: taskService)
        let controller = TaskListViewController(presenter: presenter)
        router.controller = controller
        
        return controller
    }
}
