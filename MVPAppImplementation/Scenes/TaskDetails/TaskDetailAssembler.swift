//
//  TaskDetailAssembler.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

class TaskDetailAssembler {
    
    static func assembly(task: TaskEntity) -> UIViewController {
        
        let router = TaskDetailRouterImpl()
        let presenter = TaskDetailsPresenterImpl(task: task, router: router)
        let view = TaskDetailViewController(presenter: presenter)
        
        return view
    }
}
