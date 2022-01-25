//
//  TaskDetailsPopupAssembler.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 24.01.2022.
//

import UIKit

final class TaskDetailsPopupAssembler {
    
    class func assembly(taskIndex index: Int) -> UIViewController {
        let taskSettings = TaskSettingsImpl()
        let presenter = TaskDetailsPopupPresenterImpl(index: index, taskSettings: taskSettings)
        let view = TaskDetailsPopupViewController(presenter: presenter)
        
        return view
    }
}
