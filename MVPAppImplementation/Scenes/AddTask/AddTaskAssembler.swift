//
//  AddTaskAssembly.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

final class AddTaskAssembler {
    var addTaskPresenterDelegatew: AddTaskPresenterDelegate?
    
    init(addTaskPresenterDelegate: AddTaskPresenterDelegate?) {
        self.addTaskPresenterDelegatew = addTaskPresenterDelegate
    }
    
    func assembly() -> UIViewController {
        let presenter = AddTaskPresenterImpl(delegate: addTaskPresenterDelegatew)
        let view = AddTaskViewController(presenter: presenter)
        
        return view
    }
}
