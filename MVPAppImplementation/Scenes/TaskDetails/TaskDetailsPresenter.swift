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
    func onViewAttached(view: TaskDetailView, navigationController: UINavigationController?)
    func removeButtonDidPressed()
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
    
    func onViewAttached(view: TaskDetailView, navigationController: UINavigationController?) {
        self.view = view
        view.setTask(task: task)
        router.set(navigationController: navigationController)
    }
    
    func removeButtonDidPressed() {
        router.popViewController(animated: false)
        deleteComplition(task)
    }
}
