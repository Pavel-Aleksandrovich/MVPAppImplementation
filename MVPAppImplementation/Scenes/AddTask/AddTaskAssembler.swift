//
//  AddTaskAssembly.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

final class AddTaskAssembler {
    
    class func assembly(index: Int?) -> UIViewController {
        
        let router = AddTaskRouterImpl()
        let taskSettings = TaskSettingsImpl()
        let presenter = AddTaskPresenterImpl(router: router, taskSettings: taskSettings, index: index)
        let controller = AddTaskViewController(presenter: presenter)
        router.controller = controller
        
        return controller
    }
}
