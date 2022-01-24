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
    private let indexForTaskDetails: Int
    private weak var view: TaskDetailView?
    private let router: TaskDetailRouter
    private var taskSettings: TaskSettings
    
    init(indexForTaskDetails: Int, router: TaskDetailRouter, taskSettings: TaskSettings) {
        self.indexForTaskDetails = indexForTaskDetails
        self.router = router
        self.taskSettings = taskSettings
    }
    
    func onViewAttached(view: TaskDetailView) {
        let task = taskSettings.getTaskByIndex(index: indexForTaskDetails)
        self.view = view
        view.setTask(task: task)
    }
    
    func removeButtonDidPressed(navigationController: UINavigationController?) {
        router.popViewController(animated: false, navigationController: navigationController)
        taskSettings.removeTask(index: indexForTaskDetails)
    }
}
