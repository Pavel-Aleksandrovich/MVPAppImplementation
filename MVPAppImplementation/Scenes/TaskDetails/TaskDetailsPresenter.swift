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
    func popViewController(view: TaskDetailViewController)
}

class TaskDetailsPresenterImpl: TaskDetailsPresenter {
    private var task: TaskEntity
    private weak var view: TaskDetailView?
    private var router: TaskDetailRouter
    
    init(task: TaskEntity, router: TaskDetailRouter) {
        self.task = task
        self.router = router
    }
    
    func onViewAttached(view: TaskDetailView) {
        self.view = view
    }
    func setTitle() {
        view?.setTitle(title: task.taskTitle)
    }
    
    func popViewController(view: TaskDetailViewController) {
        router.popViewController(view: view, animated: false)
    }
}
