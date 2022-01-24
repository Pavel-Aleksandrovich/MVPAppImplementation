//
//  TaskDetailAssembler.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

final class TaskDetailAssembler {
    
    class func assembly(indexForTaskDetails: Int) -> UIViewController {
        
        let router = TaskDetailRouterImpl()
        let taskSettings = TaskSettingsImpl()
        let presenter = TaskDetailsPresenterImpl(indexForTaskDetails: indexForTaskDetails,
                                                 router: router,
                                                 taskSettings: taskSettings)
        let view = TaskDetailViewController(presenter: presenter)
        
        return view
    }
}
