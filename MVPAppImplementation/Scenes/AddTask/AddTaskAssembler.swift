//
//  AddTaskAssembly.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

final class AddTaskAssembler {
    
    class func assembly() -> UIViewController {
        
        let router = AddTaskRouterImpl()
        let taskSettings = TaskSettingsImpl()
        let presenter = AddTaskPresenterImpl(router: router, taskSettings: taskSettings)
        let view = AddTaskViewController(presenter: presenter)
        
        return view
    }
}
