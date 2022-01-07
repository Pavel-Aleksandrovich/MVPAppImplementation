//
//  TaskListPresenter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 07.01.2022.
//

import Foundation

protocol TaskListPresenter {
    func setTitle()
}

protocol TaskListView: AnyObject {
    func setTitle(title: String?)
}

class TaskListPresenterImplementation: TaskListPresenter {
    
    weak var view: TaskListView?
    
    func setTitle() {
        view?.setTitle(title: "Tasks")
    }
}
