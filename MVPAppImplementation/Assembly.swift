//
//  Assembly.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 07.01.2022.
//

import UIKit

class Assembly {
    
    static func assembler() -> UIViewController {
        
        let view = TaskListViewController()
        let presenter = TaskListPresenterImplementation()
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
