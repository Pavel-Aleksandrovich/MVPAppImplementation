//
//  TaskDetailsPresenter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import Foundation

protocol TaskDetailView: AnyObject {
    func setTitle(title: String?)
}

protocol TaskDetailsPresenter {
    func onViewAttached(view: TaskDetailView)
    func setTitle()
}

class TaskDetailsPresenterImpl: TaskDetailsPresenter {
     
    var task: TaskEntity
    private weak var view: TaskDetailView?
    
    init(task: TaskEntity) {
        self.task = task
    }
    
    func onViewAttached(view: TaskDetailView) {
        self.view = view
    }
    func setTitle() {
        view?.setTitle(title: task.title)
    }
    
}
