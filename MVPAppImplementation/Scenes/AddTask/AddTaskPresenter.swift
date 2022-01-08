//
//  AddTaskPresenter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 08.01.2022.
//

import UIKit

protocol AddTaskPresenter {
    func setViewBackgrounColor()
    func setViewTitle()
}

protocol addTaskView: AnyObject {
    func setViewBackgrounColor(color: UIColor?)
    func setViewTitle(title: String?)
}
final class AddTaskPresenterImplementation: AddTaskPresenter {
    weak var view: addTaskView?
    
    func setViewBackgrounColor() {
        view?.setViewBackgrounColor(color: .white.withAlphaComponent(0.9))
    }
    
    func setViewTitle() {
        view?.setViewTitle(title: "Add Task")
    }
}
