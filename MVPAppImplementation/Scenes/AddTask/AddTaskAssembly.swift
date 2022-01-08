//
//  AddTaskAssembly.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

class AddTaskAssembly {
    static func assembler() -> UIViewController {
        let view = AddTaskViewController()
        let presenter = AddTaskPresenterImplementation()
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
