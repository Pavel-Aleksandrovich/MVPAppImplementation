//
//  Assembly.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 07.01.2022.
//

import UIKit

class TaskListAssembler {
    
    static func assembly() -> UIViewController {
        
        let presenter = TaskListPresenterImpl()
        let view = TaskListViewController(presenter: presenter)
        
        return view
    }
}
