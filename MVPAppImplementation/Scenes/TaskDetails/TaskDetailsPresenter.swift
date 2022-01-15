//
//  TaskDetailsPresenter.swift
//  MVPAppImplementation
//
//  Created by pavel mishanin on 10.01.2022.
//

import UIKit

protocol TaskDetailView: AnyObject {
    func setTask(task: TaskEntity)
}

protocol TaskDetailsPresenter {
    func onViewAttached(view: TaskDetailView)
    func removeButtonDidPressed(navigationController: UINavigationController?)
}

class TaskDetailsPresenterImpl: TaskDetailsPresenter {
    private let task: TaskEntity
    private weak var view: TaskDetailView?
    private let router: TaskDetailRouter
    private let deleteComplition: (TaskEntity) -> ()
    
    init(task: TaskEntity, router: TaskDetailRouter,
         deleteComplition: @escaping (TaskEntity) -> ()) {
        self.task = task
        self.router = router
        self.deleteComplition = deleteComplition
    }
    
    func onViewAttached(view: TaskDetailView) {
        self.view = view
        view.setTask(task: task)
    }
    
    func removeButtonDidPressed(navigationController: UINavigationController?) {
        router.popViewController(animated: false, navigationController: navigationController)
        deleteComplition(task)
    }
}
