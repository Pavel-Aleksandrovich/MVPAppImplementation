//
//  AddTaskPresenter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import Foundation

protocol AddTaskPresenter {
    
}

protocol addTaskView: AnyObject {
    
}
class AddTaskPresenterImplementation: AddTaskPresenter {
    weak var view: addTaskView?
}
