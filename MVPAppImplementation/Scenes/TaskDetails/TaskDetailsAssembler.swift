//
//  AddTaskAssembly.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

final class TaskDetailsAssembler {
    
    class func assembly(index: Int?) -> UIViewController {
        
        let router = TaskDetailsRouterImpl()
        let taskSettings = TaskSettingsImpl()
        let presenter = TaskDetailsPresenterImpl(router: router, taskSettings: taskSettings, index: index)
        let controller = TaskDetailsViewController(presenter: presenter)
        router.controller = controller
        
        return controller
    }
}
