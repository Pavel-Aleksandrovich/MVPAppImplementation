//
//  Assembly.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 07.01.2022.
//

import UIKit

final class TaskListAssembler {
    
    static func assembly() -> UIViewController {
        
        let router = TaskViewRouterImpl()
        let presenter = TaskListPresenterImpl(router: router)
        let view = TaskListViewController(presenter: presenter)
        
        return view
    }
}
