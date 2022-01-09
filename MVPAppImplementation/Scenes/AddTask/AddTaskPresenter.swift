//
//  AddTaskPresenter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

protocol AddTaskPresenterDelegate: AnyObject {
    func addTaskPresenter(presenter: AddTaskPresenter, task: TaskEntity)
}

protocol AddTaskPresenter {
    func setViewBackgrounColor()
    func setViewTitle()
    func addButtonPressed(parametrs: TaskEntity)
}

protocol addTaskView: AnyObject {
    func setViewBackgrounColor(color: UIColor?)
    func setViewTitle(title: String?)
    
}
final class AddTaskPresenterImplementation: AddTaskPresenter {
    weak var view: addTaskView?
    weak var delegate: AddTaskPresenterDelegate?
//    var task: [AddTask]
    
    init(delegate: AddTaskPresenterDelegate?) {
        self.delegate = delegate
    }
    
    func setViewBackgrounColor() {
        view?.setViewBackgrounColor(color: .white.withAlphaComponent(0.9))
    }
    
    func setViewTitle() {
        view?.setViewTitle(title: "Add Task")
    }
    
    func addButtonPressed(parametrs: TaskEntity) {
        delegate?.addTaskPresenter(presenter: self, task: parametrs)
    }
}
