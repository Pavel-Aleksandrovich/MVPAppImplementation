//
//  AddTaskAssembly.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

final class AddTaskAssembler {
    
    static func assembly(addTaskPresenterDelegate: AddTaskPresenterDelegate) -> UIViewController {
        let router = AddTaskRouterImpl()
        let presenter = AddTaskPresenterImpl(router: router, delegate: addTaskPresenterDelegate)
        let view = AddTaskViewController(presenter: presenter)
        
        return view
    }
}
