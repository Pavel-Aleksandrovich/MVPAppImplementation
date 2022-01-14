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
        let taskSettings = TaskSettings()
        let presenter = TaskListPresenterImpl(router: router, taskSettings: taskSettings)
        let view = TaskListViewController(presenter: presenter)
        
        return view
    }
}
