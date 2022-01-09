//
//  AddTaskAssembly.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

class AddTaskAssembly {
    var addTaskPresenterDelegatew: AddTaskPresenterDelegate?
    
    init(addTaskPresenterDelegate: AddTaskPresenterDelegate?) {
        self.addTaskPresenterDelegatew = addTaskPresenterDelegate
    }
    
    func assembler() -> UIViewController {
        let view = AddTaskViewController()
        let presenter = AddTaskPresenterImplementation(delegate: addTaskPresenterDelegatew)
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
