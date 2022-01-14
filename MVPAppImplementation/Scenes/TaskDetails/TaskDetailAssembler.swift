//
//  TaskDetailAssembler.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

final class TaskDetailAssembler {
    
    class func assembly(task: TaskEntity,
                         deleteComplition: @escaping (TaskEntity) -> ()) -> UIViewController {
        
        let router = TaskDetailRouterImpl()
        let presenter = TaskDetailsPresenterImpl(task            : task,
                                                 router          : router,
                                                 deleteComplition: deleteComplition)
        let view = TaskDetailViewController(presenter: presenter)
        
        return view
    }
}
