//
//  TaskDetailAssembler.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

class TaskDetailAssembler {
    
    static func assembly(task: TaskEntity) -> UIViewController {
        let presenter = TaskDetailsPresenterImpl(task: task)
        let view = TaskDetailViewController(presenter: presenter)
        
        return view
    }
}
